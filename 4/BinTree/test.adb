with BinTree_ADT;
with Ada.Integer_Text_IO;
with Ada.Text_IO;
with Ada.Characters.Handling;


procedure test is
   procedure Put(X : Integer) is
   begin
      Ada.Integer_Text_IO.Put(X);
   end put;

   package IntTree is new BinTree_ADT(Element_T => Integer, Key_T => Integer, "<=" => "<=", print => Put);
   use IntTree;
   tree : BinTree_Access_T;
   button : Character := '-';
begin
   tree := Create;
   Insert(tree,5,5);
   Insert(tree,3,3);
   Insert(tree,4,4);
   Insert(tree,6,6);
   Insert(tree,8,8);
   Insert(tree,7,7);
   PrintList(tree);
   PrintTree(tree);
   Delete(tree,5);
   PrintTree(tree);
   Delete(tree,6);
   PrintTree(tree);
   while not Ada.Characters.Handling.Is_Line_Terminator(button) loop
      Ada.Text_IO.Get_Immediate(button);
   end loop;
end test;
