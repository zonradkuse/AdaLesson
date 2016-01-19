with Ada.Text_IO; use Ada;
procedure Simple is

   type A_T is  abstract tagged null record;

   type B_T is new A_T with record
        a : Boolean;
   end record;

   procedure print(A : in out A_T) is
   begin
      Ada.Text_IO.Put_Line ("A");
   end print;

   procedure print(B : in out B_T)
   is
   begin
      Ada.Text_IO.Put_Line ("B");
   end print;
   b : B_T := (A_T => true);
   a : A_T'Class := b;
begin
    print(a); -- should print B
end Simple;
