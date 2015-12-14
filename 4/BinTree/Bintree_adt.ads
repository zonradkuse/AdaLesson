generic
	type Element_T is private;
	type Key_T is private;
   with function "<=" (X,Y :  Key_T) return Boolean;
   with procedure print(X : Element_T);
package BinTree_ADT is
	type BinTree_Access_T is private;
	function Create return BinTree_Access_T;
	procedure Dealloc(tree : in out BinTree_Access_T);
	procedure Insert(tree : in out BinTree_Access_T; elem : in Element_t; key : Key_T);
	procedure Delete(tree : in out BinTree_Access_T; key : Key_T);
	procedure PrintList(tree : in BinTree_Access_T);
	procedure PrintTree(tree : in BinTree_Access_T);
    function Search(tree : BinTree_Access_T; key : Key_T) return Element_T;
	NoSuchElement : exception;

private
	type BinTree_T;
	type BinTree_Access_T is access BinTree_T;
end BinTree_ADT;

