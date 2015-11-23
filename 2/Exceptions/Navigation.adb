with Ada.Text_IO;
use Ada.Text_IO;

procedure Navigation is 
	Position_Failure : exception;
	Navigation_Failure : exception;

	subtype Position_Type is Integer range 0..100;
	
	procedure Get_Position1 (Position : out Position_Type) is 

	begin
		Put_Line("Entered 1. Position is: " & Integer'Image(Position));
		raise Position_Failure;
	end Get_Position1;

	procedure Get_Position2 (Position : out Position_Type) is 

	begin
		Put_Line("Entered 2. Position is: " & Integer'Image(Position));
		raise Position_Failure;
	end Get_Position2;

	procedure Get_Position3 (Position : out Position_Type) is 

	begin
		Put_Line("Entered 3. Position is: " & Integer'Image(Position));
		raise Position_Failure;
	end Get_Position3;

	pos : Position_Type;

begin
	begin
		Get_Position1(pos);
	exception
		when Position_Failure => 
			begin
				Get_Position2(pos);
			exception
				when Position_Failure =>
					begin
						Get_Position3(pos);
					exception
						when Position_Failure => 
							Put_Line("Everything handled and we still failed. Raise Navigation_Failure");
							raise Navigation_Failure;
					end;
			end;
	end;

end Navigation;
