with Ada.Text_IO; use Ada.Text_IO;
procedure Dining_Philosophers is
	protected type Fork is
		entry take;
		entry put;
	private
		taken : Boolean := false;
	end Fork;

	protected body Fork is
		entry take when taken = false is

		begin
			taken := true;
		end take;
		entry put when taken = true is

                begin
                        taken := false;
                end put;
	end Fork;

	Klaus, Dieter, Achim, Manfred, Bernhard : Fork;

	task F1;
	task body F1 is
	begin
		loop
			Put_Line("F1 is hungry");
			Klaus.take;
			Put_Line("F1 taken Klaus");
			Dieter.take;
			Put_Line("F1 taken Dieter");
			Put_Line("F1 eats as much as he can!");
			-- wait random time
			delay 0.2;
			Klaus.put;
			Dieter.put;
			delay 0.2;
			-- wait some random time
		end loop;
	end;
	task F2;
	task body F2 is
	begin
		loop
			Put_Line("F2 is hungry");
			Dieter.take;
			Put_Line("F2 taken Dieter");
			Achim.take;
			Put_Line("F2 taken Achim");
			Put_Line("F2 eats as much as he can!");
			-- wait random time
			delay 0.2;
			Dieter.put;
			Achim.put;
			delay 0.2;
			-- wait some random time
		end loop;
	end;
	task F3;
	task body F3 is
	begin
		loop
			Put_Line("F3 is hungry");
			Achim.take;
			Put_Line("F3 taken Achim");
			Manfred.take;
			Put_Line("F3 taken Manfred");
			Put_Line("F3 eats as much as he can!");
			-- wait random time
			delay 0.2;
			Achim.put;
			Manfred.put;
			delay 0.2;
			-- wait some random time
		end loop;
	end;
	task F4;
	task body F4 is
	begin
		loop
			Put_Line("F4 is hungry");
			Manfred.take;
			Put_Line("F4 taken Manfred");
			Bernhard.take;
			Put_Line("F4 taken Berhard");
			Put_Line("F4 eats as much as he can!");
			-- wait random time
			delay 0.2;
			Manfred.put;
			Bernhard.put;
			delay 0.2;
			-- wait some random time
		end loop;
	end;
	task F5;
	task body F5 is
	begin
		loop
			Put_Line("F5 is hungry");
			Klaus.take;
			Put_Line("F5 taken Klaus");
			Bernhard.take;
			Put_Line("F5 taken Bernhard");
			Put_Line("F5 eats as much as he can!");
			-- wait random time
			delay 0.2;
			Klaus.put;
			Bernhard.put;
			delay 0.2;
			-- wait some random time
		end loop;
	end;

begin
	null;
end Dining_Philosophers;
