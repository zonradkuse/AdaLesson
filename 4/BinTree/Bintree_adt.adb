with Ada.Unchecked_Deallocation;
with Ada.Text_IO;

package body BinTree_ADT is
	type BinTree_T is record
		content : Element_T;
		key : Key_T;
		left : BinTree_Access_T := null;
		right : BinTree_Access_T := null;
	end record;

	procedure Free is new Ada.Unchecked_Deallocation(BinTree_T, BinTree_Access_T);


	function Create return BinTree_Access_T is
		bin : BinTree_Access_T := null;
	begin
		return bin;
	end Create;


	procedure Dealloc(tree : in out BinTree_Access_T) is
	begin
		Free(tree);
    end Dealloc;

	procedure Insert(tree : in out BinTree_Access_T; elem : in Element_t; key : Key_T) is
		temp : BinTree_Access_T := tree;
		inserted : Boolean := false;
	begin
		if tree = null then
			tree := new BinTree_T'(elem , key, null, null);
			inserted := true;
		end if;

		while not inserted loop
			if key <= temp.key then
				if temp.left = null then
					temp.left := new BinTree_T'(elem, key,null,null);
					inserted := true;
				else
					temp := temp.left;
				end if;
			else
				if temp.right = null then
					temp.right := new BinTree_T'(elem, key,null,null);
					inserted := true;
				else
					temp := temp.right;
				end if;
			end if;
		end loop;

	end Insert;

	procedure Delete(tree : in out BinTree_Access_T; key : Key_T) is
		temp : BinTree_Access_T := tree;
		upper : BinTree_Access_T;
	begin
		if key = tree.key then
			if temp.left /= null then
				upper := temp;
				temp := temp.left;
				if temp.right = null then
					tree.content := temp.content;
					tree.key := temp.key;
					Dealloc(tree);
					upper.left := null;
				else
					while temp.right /= null loop
						upper := temp;
						temp := temp.right;
					end loop;
					tree.content := temp.content;
					tree.key := temp.key;
					Dealloc(temp);
					upper.right := null;
				end if;
			elsif temp.right /= null then
				upper := temp;
				temp := temp.right;
				if temp.left = null then
					tree.content := temp.content;
					tree.key := temp.key;
					Dealloc(tree);
					upper.right := null;
				else
					while temp.left /= null loop
						upper := temp;
						temp := temp.left;
					end loop;
					tree.content := temp.content;
					tree.key := temp.key;
					Dealloc(temp);
					upper.left := null;
				end if;
			else
				Dealloc(temp);
				tree := null;
			end if;
		elsif key <= tree.key then
			Delete(tree.left, key);
		else
			Delete(tree.right, key);
		end if;
	end Delete;

	procedure PrintList(tree : in BinTree_Access_T) is
		procedure PrintListRecursive(tree : in BinTree_Access_T) is
		begin
			if tree /= null then
				PrintListRecursive(tree.left);
				Print(tree.content);
				Ada.Text_IO.put(' ');
				PrintListRecursive(tree.right);
			end if;
		end PrintListRecursive;
	begin
		PrintListRecursive(tree);
		Ada.Text_IO.New_Line;
	end PrintList;

	procedure PrintTree(tree : in BinTree_Access_T) is
		procedure PrintTreeRecursive(tree : in BinTree_Access_T) is
		begin
			if tree /= null then
				Print(tree.content);
				Ada.Text_IO.put('(');
				PrintTreeRecursive(tree.left);
				Ada.Text_IO.put(',');
				PrintTreeRecursive(tree.right);
				Ada.Text_IO.put(')');
			else
				Ada.Text_IO.put('-');
			end if;
		end PrintTreeRecursive;
	begin
		PrintTreeRecursive(tree);
		Ada.Text_IO.New_Line;
	end PrintTree;
end BinTree_ADT;
