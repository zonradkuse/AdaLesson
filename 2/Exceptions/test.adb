-- Test file for how exceptions might be handled

with Ada.Text_IO;
use Ada.Text_IO;

procedure Procedure_outer is
	my_ex : Exception;

	procedure Procedure_inner is
		procedure Procedure_inner_in is
			procedure my_proc is
				
			begin -- my_proc
				raise my_ex;
			end my_proc;
		begin -- Procedure
			my_proc;
		end Procedure_inner_in;
	begin -- Procedure

		Procedure_inner_in;
	end Procedure_inner;

begin -- Procedure

--	begin
		Procedure_inner;
--	exception 
--		when my_ex => 
--			Put_Line("outer procedure catched my_ex"); 
--	end;

end Procedure_outer;
