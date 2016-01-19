with SimpleParent; use SimpleParent;
with Ada.Text_IO; use Ada;
procedure Simple is

   type B_T is new A_T with record
        c : Character;
   end record;

  

   procedure print(B : in out B_T)
   is
   begin
      Ada.Text_IO.Put(B.c);
   end print;

  b : B_T := (c => 'd');
  ab : A_T'Class := b;
  a : A_T;
begin
  print(ab); -- should print B
  print(a);   -- should print A
end Simple;
