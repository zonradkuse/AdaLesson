-- written by: Michael von Wenckstern and Achim Lindt
-- purpose: let the students get a feeling of Ada

with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

-- Procedure TicTacToe implements the game
-- specification can be found at
-- http://de.wikipedia.org/wiki/Tic_Tac_Toe
procedure Game is
   FieldLengthInput : Natural;
   type T_GameMode is (AI, Mulitplayer);
   GameMode     : T_GameMode; 

   function determineFieldSize return Natural is 
      input : String (1..2);
      size : Natural;
   begin
      Put_Line("What field size would you like to have?");
      Put("> ");
      Get_Line(input, size);
      Skip_Line;
      return Natural'Value(input(1..size));
   end determineFieldSize;

   procedure TicTacToe (FieldLength: in Natural) is
      -- 2) Type declarations to define needed types
      type T_Players is (None, Player1, Player2);
      -- only two players can play the game
      -- can be extended that only one player
      -- exists and the other one is a PC

      type T_FieldLengthSquare is range 1 .. FieldLength**2;
      subtype T_FieldSize is T_FieldLengthSquare range 1 .. FieldLength;

      type T_Field is array (T_FieldSize, T_FieldSize) of T_Players;

      type T_BoardPosition is record
         Row, Col : T_FieldSize;
      end record;


      -- 3) Variable declarations with standard of self-defined types
      GameBoard    : T_Field             := (others => (others => None));
      Round        : T_FieldLengthSquare := 1;
      UserInput    : T_FieldLengthSquare;
      ActivePlayer : T_Players;


   -------------------------------------------------------------------------------------------------------------------------
   -------------------------------------------------------------------------------------------------------------------------


   -- @Return: a two dimensional representation of the one dimensional array index
      function GetBoardPosition
        (FieldIndex : T_FieldLengthSquare) return T_BoardPosition
      is
         Result : T_BoardPosition;
      begin
         Result.Row := (FieldIndex - 1) / FieldLength + 1;
         Result.Col := (FieldIndex - 1) mod FieldLength + 1;
         return Result;
      end GetBoardPosition;

   -------------------------------------------------------------------------------------------------------------------------
   -------------------------------------------------------------------------------------------------------------------------


      -- @Return: A number 1 to FieldLength**2 representing the position
      -- where the actual player wants to set its marker
      function ReadUserInput return T_FieldLengthSquare is
         Result        : T_FieldLengthSquare;
         PositionIndex : Integer;

         -- @Return: true if GameBoard does not contain a chip of any players
         function IsFieldValid
           (FieldIndex : T_FieldLengthSquare) return Boolean
         is
            Position : T_BoardPosition;
         begin
            Position := GetBoardPosition (FieldIndex);
            return GameBoard (Position.Row, Position.Col) = None;
         end IsFieldValid;

      begin
         loop
            Put ("Enter a number from 1 to ");
            Put (FieldLength**2);
            Put (" :");
            declare
               line : String (1 .. 5);
               size   : Natural;
            begin
               Get_Line (line, size);
               PositionIndex := Integer'Value (line (1 .. size));
            end;
            exit when (PositionIndex >= 1 and PositionIndex <= FieldLength**2)
              and then IsFieldValid (T_FieldLengthSquare (PositionIndex));
            Put_Line ("");
         end loop;
         Result := T_FieldLengthSquare (PositionIndex);
         return Result;
      end ReadUserInput;

   -------------------------------------------------------------------------------------------------------------------------
   -------------------------------------------------------------------------------------------------------------------------


      -- This procedure prints the playing field on the screen
      procedure PrintGameBoard is
         FieldMarker : T_Players;
         Marker      : Character;

         -- This procedure prints a seperating line with --- markers
         procedure PrintLine is
         begin
            Put_Line ("");
            Put (" ");
            for i in T_FieldSize'Range loop
               Put ("----");
            end loop;
            Put ("-"); -- one missing at the end
            Put_Line ("");
         end PrintLine;
      begin
         PrintLine;
         for Row in T_FieldSize'Range loop
            for Col in T_FieldSize'Range loop
               FieldMarker := GameBoard (Row, Col);
               case FieldMarker is
                  when Player1 =>
                     Marker := 'O';
                  when Player2 =>
                     Marker := 'X';
                  when others =>
                     Marker := ' ';
               end case;
               Put (" | " & Marker);
            end loop;
            Put (" |");
            PrintLine;
         end loop;
      end PrintGameBoard;

   -------------------------------------------------------------------------------------------------------------------------
   -------------------------------------------------------------------------------------------------------------------------


      function GetActivePlayer (Round : T_FieldLengthSquare) return T_Players is
         Player : T_Players;
      begin
         if (Round mod 2) = 1 then
            Player := Player1;
         else
            Player := Player2;
         end if;
         return Player;
      end GetActivePlayer;

   -------------------------------------------------------------------------------------------------------------------------
   -------------------------------------------------------------------------------------------------------------------------


      -- This procedure sets the player marker to the selected field based
      -- on the Round number
      procedure SetValueToGameBoard
        (Index : T_FieldLengthSquare;
         Round : T_FieldLengthSquare)
      is
         Position : T_BoardPosition := GetBoardPosition (Index);
      begin
         GameBoard (Position.Row, Position.Col) := GetActivePlayer (Round);
      end SetValueToGameBoard;

   -------------------------------------------------------------------------------------------------------------------------
   -------------------------------------------------------------------------------------------------------------------------


      -- @Return: True if one player won the game
      function CheckWin return Boolean is
         Result : Boolean := False;

         -- checks whether the given player has all stones in a row, a column,
         -- or a diagonale
   	  -- very simple/naive implementation, may be revised by improved algorithm
         function CheckWinForPlayer (Player : T_Players) return Boolean is
            Result : Boolean := True;
         begin
            -- Check horizontal win strategy
            for Row in T_FieldSize'Range loop
               Result := True;
               for Col in T_FieldSize'Range loop
                  Result := Result and (GameBoard (Row, Col) = Player);
                  exit when not Result; -- it is false, so it will not become true again
               end loop;
               exit when Result; -- it is true, so a complete row has been found
            end loop;

            -- Check vertical win strategy
            if not Result then
               for Col in T_FieldSize'Range loop
                  Result := True;
                  for Row in T_FieldSize'Range loop
                     Result := Result and (GameBoard (Row, Col) = Player);
                     exit when not Result; -- it is false, so it will not become true again
                  end loop;
                  exit when Result; -- it is true, so a complete column has been found
               end loop;
            end if;

            -- Checking for Diagonale (1,1), (2,2), (3,3)
            if not Result then
               Result := True;
               for Diag in T_FieldSize'Range loop
                  Result := Result and (GameBoard (Diag, Diag) = Player);
                  exit when not Result; -- it is false, so it will not become true again
               end loop;
            end if;

            -- Checking for Anti-Diagonale (1,3), (2,2), (3, 1)
            if not Result then
               Result := True;
               for Diag in T_FieldSize'Range loop
                  Result :=
                    Result and
                    (GameBoard (Diag, FieldLength - Diag + 1) = Player);
                  exit when not Result; -- it is false, so it will not become true again
               end loop;
            end if;

            return Result;
         end CheckWinForPlayer;

      begin
         if CheckWinForPlayer (Player1) then
            Put_Line ("Player 1 won. Congratulations!");
            Result := True;
         elsif CheckWinForPlayer (Player2) then
            Put_Line ("Player 2 won. Congratulations!");
            Result := True;
         else
            Result := False;
         end if;
         return Result;
      end CheckWin;

      function determineGameMode return T_GameMode is
         Mode : T_GameMode := AI;
         UserInput : String(1..2);
         Size : Natural;
      begin
         Put_Line("Choose a Game Mode:");
         Put_Line("AI - Single player mode.");
         Put_Line("MP - 2 Player mode.");
         Put("> ");
         Get_Line(UserInput, Size);
         if UserInput = "AI" then
            Put_Line("Selected Mode is Multiplayer");
            Mode := Mulitplayer;
         else 
            Put_Line("Selected Mode is Singleplayer");
            Mode := AI;
         end if;
         Put_Line(""); 
         Skip_Line;
         return Mode;
      end determineGameMode;
   -------------------------------------------------------------------------------------------------------------------------
   -------------------------------------------------------------------------------------------------------------------------


   -- MAIN program
   begin
      Put_Line ("Welcome to TIC-TAC-TOE");

      -- determine if this is a mulitplayer game or player wants to loose against AI.
      
      for Round in T_FieldLengthSquare'Range loop
         ActivePlayer := GetActivePlayer (Round);
         case ActivePlayer is
            when Player1 =>
               Put ("Player 1 > ");
            when others =>
               Put ("Player 2 > ");
         end case;
         UserInput := ReadUserInput;
         SetValueToGameBoard (UserInput, Round);
         PrintGameBoard;
         exit when CheckWin;
      end loop;
      Put_Line ("Press Enter to Exit the Program.");
      declare
         Input : String (1 .. 5);
         Size  : Natural;
      begin
         Get_Line (Input, Size);
      end;
   end TicTacToe;

begin
   FieldLengthInput := determineFieldSize;
   GameMode := determineGameMode;
   TicTacToe (FieldLengthInput);
end Game;
