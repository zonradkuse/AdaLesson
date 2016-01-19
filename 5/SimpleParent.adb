with Ada.Text_IO; use Ada;

package body SimpleParent is
	procedure print(A: in out A_T)
  is
   begin
      Ada.Text_IO.Put_Line ("A");
   end print;
end SimpleParent;