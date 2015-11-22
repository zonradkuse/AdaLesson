-- Rekursiver Abstiegsparser für einfache Ausdrücke.
-- Das Programm liest aus der Datei "Test" im aktuellen Arbeitsverzeichnis
-- und führt einen Syntaxcheck durch. Syntaktisch korrekte Ausdrücke
-- genügen der folgenden Grammatik:

-- Start         ::= expression '.'
-- expression    ::= [addop] term {addop term}
-- addop         ::= '+' | '-'
-- term          ::= factor {multop factor}
-- multop        ::= '*' | '/'
-- factor        ::= ident | number | '(' expression ')'

with Ada.Text_IO; with Text_IO; use Text_IO;

procedure Parser is

   Nmax : 	constant Integer := 14;  -- max. Anzahl von Ziffern einer Zahl
   ILen : 	constant Integer := 10;  -- max. Länge eines Bezeichers
   Maxerr : constant Integer := 3; 	 -- zul. Anzahl von Fehlern vor Abbruch der Analyse

   type Symbol is (Nul, Ident, Number, Plus, Minus, Times, Slash, LBracket, RBracket, Period);
   type SymbolSet is array (Symbol) of Boolean;

   NoClosingBracket, WrongSymbolFactorEnd, ExpressionWrongSymbol, NumberOrIdentTooLong, MissingPeriod, TooManyErrors : exception;

   Eingabe : Text_IO.File_Type;
   Sym : Symbol := Nul;			 -- Zuletzt gelesenes Symbol
   Ch : Character := ' ';	         -- Zuletzt gelesenes Zeichen
   NErrors : Integer := 0;		 -- Anzahl bisher aufgetretener Fehler

   function IsIn (Sym : Symbol; SymSet : SymbolSet) return Boolean is
   begin
      return SymSet(Sym);
   end IsIn;

   function Union (Set1, Set2 : SymbolSet) return SymbolSet is
   begin
      return Set1 or Set2;
   end Union;

   procedure CountError is
   begin
      NErrors := NErrors + 1;
      if NErrors > Maxerr then raise TooManyErrors; end if;
   end CountError;

   procedure GetSym is

      subtype Letter is Character range 'a'..'z';
      subtype Digit is Character range '0'..'9';
      subtype StateRange is Integer range 0..2;
      state : StateRange := 0;
      bool : Boolean;
      currentILen : Integer := 0;

   begin
      while not End_Of_File loop
         Look_Ahead(Eingabe,Ch,bool);
         if Ch = ' ' then
            Get(Ch);
            goto continue;               -- Überspringe ein Leerzeichen
         end if;

         -- Innerhalb dieses Schleifenrumpfs soll ein Scanner implementiert werden,
         -- der der Variablen Sym ein Element des Aufzählungstyps Symbol zuordnet.
         -- Benutzen Sie den Ausnahmetyp NumberOrIdentTooLong falls ein einzelnes
         -- Symbolelement zu lang (> Nmax) ist.
         --
         -- Hinweis: Sie benötigen drei verschiedene Zustände, in denen sich der Scanner
         -- befinden kann.
         --
         -- Beginn des Scanner-Blocks






































         -- Ende des Scanner-Blocks
         <<continue>>
         null;
      end loop;
      goto ende;
      -- Durch Anspringen dieser Marke wird ein Zeichen aus der Eingabe entfernt,
      -- und der Scanner beendet.
      <<consume>> Get(Ch);
      <<ende>> null;
   end GetSym;

   procedure Recover (S : SymbolSet) is
   begin
      Put_Line("!! Recover !!");
      while not IsIn(Sym, S) loop GetSym; end loop;
   end Recover;

   procedure Test (S1, S2 : SymbolSet) is
      Un : SymbolSet := Union(S1, S2);
   begin
      if not IsIn(Sym, S1) then
         CountError;
         while not IsIn(Sym, Un) loop GetSym; end loop;
      end if;
   end Test;

   FacBeginSyms : constant SymbolSet := (Ident => True, Number => True, LBracket => True, others => False);

   procedure Expression (fsys : SymbolSet) is

      procedure Term (fsys : SymbolSet) is

         procedure Factor (fsys : SymbolSet) is
         begin
            Put_Line(">>> Factor.enter");
            if not IsIn(Sym, FacBeginSyms) then return; end if; -- Bei Vorliegen eines ungeeigneten Symbols sollte eine Fehlerbehandlung erfolgen
            while IsIn(Sym, FacBeginSyms) loop
               if Sym = Ident or Sym = Number then
                  GetSym;
               elsif Sym = LBracket then
                  GetSym;
                  Expression(Union(Fsys, SymbolSet'(RBracket=>True, others => False)));
                  if Sym = RBracket then
                     GetSym;
                  else
                     return; -- Auf eine linke Klammer muss eine rechte folgen, sonst Fehler
                  end if;
               end if;
            end loop;
            if not IsIn(Sym, Fsys) then return; end if; -- Das nächste Symbol sollte in der Follow-Menge von Factor liegen, sonst Fehler
            Put_Line("<<< Factor.exit");
            -- Im Fehlerfall sollte dieser gezählt werden und durch ein Recovery
            -- so fortgefahren werden, dass Factor als nächste Parserregel angewendet
            -- werden kann.
         end Factor;

      begin
         Put_Line(">>> Term.enter");
         NErrors := 0;
         Factor(Union(Fsys, SymbolSet'(Slash => True, Times => True, others => False)));
         while Sym = Times or Sym = Slash loop
            GetSym;
            NErrors := 0;
            Factor(Union(Fsys, SymbolSet'(Slash => True, Times => True, others => False)));
         end loop;
         Put_Line("<<< Term.exit");
      end Term;

   begin
      Put_Line(">>> Expression.enter");
      if Sym = Plus or Sym = Minus then
         GetSym;
      end if;
      Term(Union(Fsys, SymbolSet'(Plus => True, Minus => True, others=>False)));
      while Sym = Plus or Sym = Minus loop
         GetSym;
         Term(Union(Fsys, SymbolSet'(Plus => True, Minus => True, others => False)));
      end loop;
      Put_Line("<<< Expression.exit");
   end Expression;


   StopSyms : SymbolSet := (Period => True, others => False);

begin
   Open(File => Eingabe, Mode => In_File, Name => "Test");
   Set_Input(Eingabe);
   GetSym;
   Expression(StopSyms);
   if Sym /= Period then raise MissingPeriod; end if;
   Close(Eingabe);
end Parser;
