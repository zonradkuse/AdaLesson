with BinTree_ADT;
with Ada.Integer_Text_IO;
with Ada.Text_IO;
with Ada.Characters.Handling;
with Ada.Float_Text_IO;
with Ada.Strings.Equal_Case_Insensitive;
with Ada.Strings.Less_Case_Insensitive; use Ada.Strings;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
use Ada.Text_IO;

procedure test is

	procedure testFloat is
		type ItemArray_T is array (Positive range <>) of Float;
		procedure PutFloat(X : Float) is
	   	begin
	      Ada.Float_Text_IO.Put(Item => X, Aft => 3, Exp => 0);
	   	end PutFloat;

	   	package FloatTree is new BinTree_ADT(Element_T => Float, Key_T => Float, "<=" => "<=", print => PutFloat);
		use FloatTree;
		tree : BinTree_Access_T;
		items : ItemArray_T := (5.5, 3.3, 5.4, 5.6, 5.8, 5.7, 5.78);
   	begin
   		Put_Line("Input values: ");
		for index in items'First .. items'Last-1 loop
			PutFloat(items(index));
		end loop;
		New_Line;
		New_Line;

		Put_Line("Initial state: ");
   		tree := Create;
   		for index in items'First .. items'Last-1 loop
			Insert(tree,items(index),items(index));
		end loop;
		PrintList(tree);
		PrintTree(tree);
		New_Line;

		Put_Line("After add: " & Float'Image(items(items'Last)));
		Insert(tree, items(items'Last), items(items'Last));
		PrintList(tree);
		PrintTree(tree);
		New_Line;

		Put_Line("After delete: " & Float'Image(5.6));
		Delete(tree, 5.6);
		PrintList(tree);
		PrintTree(tree);
		New_Line;
		New_Line;

		Dealloc(tree);
   	end testFloat;

   	procedure testChar is
		type ItemArray_T is array (Positive range <>) of Character;

	   	package CharTree is new BinTree_ADT(Element_T =>  Character, Key_T =>  Character, "<=" => "<=", print => Put);
		use CharTree;
		tree : BinTree_Access_T;
		items : ItemArray_T := ('g','c','f','k','i','j','e');
   	begin
   		Put_Line("Input values: ");
		for index in items'First .. items'Last-1 loop
			Put(items(index));
		end loop;
		New_Line;
		New_Line;

		Put_Line("Initial state: ");
   		tree := Create;
   		for index in items'First .. items'Last-1 loop
			Insert(tree,items(index),items(index));
		end loop;
		PrintList(tree);
		PrintTree(tree);
		New_Line;

		Put_Line("After add: " & items(items'Last));
		Insert(tree, items(items'Last), items(items'Last));
		PrintList(tree);
		PrintTree(tree);
		New_Line;

		Put_Line("After delete: f");
		Delete(tree, 'f');
		PrintList(tree);
		PrintTree(tree);
		New_Line;
		New_Line;

		Dealloc(tree);
   	end testChar;


   	procedure testString is

		type ItemArray_T is array (Positive range <>) of Unbounded_String;

		function less_Or_Equal (left, right : Unbounded_String) return Boolean
		is
			leftString : String := To_String(left);
			rightString : String := To_String(right);
		begin
			return (Ada.Strings.Less_Case_Insensitive(leftString, rightString) or
					Ada.Strings.Equal_Case_Insensitive(leftString, rightString));
		end less_Or_Equal;


	   	package StringTree is new BinTree_ADT(Element_T =>  Unbounded_String, Key_T =>  Unbounded_String, "<=" => less_Or_Equal , print => Put);
		use StringTree;
		tree : BinTree_Access_T;
		items : ItemArray_T:= (
								To_Unbounded_String("ada"),
								To_Unbounded_String("exercise"),
								To_Unbounded_String("embedded"),
								To_Unbounded_String("crosscompiler"),
								To_Unbounded_String("arduino"),
								To_Unbounded_String("heat"),
								To_Unbounded_String("rat"),
								To_Unbounded_String("radioactivity")
								);

   		begin

   		Put_Line("Input values: ");
		for index in items'First .. items'Last-1 loop
			Put(items(index));
			Put(" ");
		end loop;
		New_Line;
		New_Line;

		Put_Line("Initial state: ");
   		tree := Create;
   		for index in items'First .. items'Last-1 loop
			Insert(tree,items(index),items(index));
		end loop;
		PrintList(tree);
		PrintTree(tree);
		New_Line;

		Put_Line("After add: " & items(items'Last));
		Insert(tree, items(items'Last), items(items'Last));
		PrintList(tree);
		PrintTree(tree);
		New_Line;

		Put_Line("After delete: rat");
		Delete(tree, To_Unbounded_String("rat"));
		PrintList(tree);
		PrintTree(tree);
		New_Line;
		New_Line;

		Dealloc(tree);
   	end testString;

   	button : Character := '-';
begin
	testFloat;
   testChar;
   testString;
--  	PrintList(tree);
--  	PrintTree(tree);
--  	Delete(tree,5);
--  	PrintTree(tree);
--  	Delete(tree,6);
--  	PrintTree(tree);
--  	Put(Search(tree,2));
--  	Ada.Text_IO.New_Line;
	--while not Ada.Characters.Handling.Is_Line_Terminator(button) loop
	--  Ada.Text_IO.Get_Immediate(button);
	--end loop;
end test;
