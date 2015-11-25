with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Matrix is
   	-- a)
   	type MatrixContent is array (Integer range <>, Integer range <>) of Float;
   	type MatrixRecord (r: positive; c: positive ) is record
      	rows : positive := r;
      	cols : positive := c;
      	content : MatrixContent(1..r, 1..c);
   	end record;

    --wrongFormatException : exception;
    matrixX : MatrixRecord(3,4);
    matrixA : MatrixRecord(3,3);
    matrixB : MatrixRecord(3,3);

   	matrixC : MatrixRecord(3,3);
   	matrixD : MatrixRecord(2,3);
   	matrixE : MatrixRecord(3,2);
   	matrixF : MatrixRecord(2,2);

   	matrixDContent : MatrixContent := ((1.0,2.0,3.0),(4.0,5.0,6.0));
   	matrixEContent : MatrixContent := ((6.0,3.0),(5.0,2.0),(4.0,1.0));



    procedure Print(matrix : MatrixRecord) is

    begin
    	for r in 1..matrix.rows loop
            for c in 1..matrix.cols loop
            	Put(matrix.content(r,c));
            end loop;
            New_Line;
        end loop;
   	end Print;


	-- b)
	procedure Init (matrix : IN OUT MatrixRecord)is

	begin
        	matrix.content := (others =>(others =>0.0));
   	end Init;

    -- c)
	function "+" (A,B : MatrixRecord) return MatrixRecord is
		C : MatrixRecord(A.rows,A.cols);
	begin
		--if(A.rows != B.rows or else A.cols != B.cols){
		--	raise wrongFormatException;
		--}
      	for row in 1..A.rows loop
      		for col in 1..A.cols loop
      			C.content(row,col) := A.content(row,col) + B.content(row,col);
      		end loop;
      	end loop;
      	return C;
	end "+";

	function "*" (A,B : MatrixRecord) return MatrixRecord is
		C : MatrixRecord(A.rows,B.cols);
		sum : Float;
	begin
		--if(A.cols != B.rows){
		--	raise wrongFormatException;
		--}
		for Arow in 1..A.rows loop
			for Bcol in 1..B.cols loop
				sum := 0.0;
				for index in 1..A.cols loop
					sum := sum + (A.content(Arow,index)*B.content(index, Bcol));
				end loop;
				C.content(Arow,Bcol) := sum;
			end loop;
		end loop;
		return C;
	end "*";
	--d)
	procedure Read(matrix : IN OUT MatrixRecord) is
		currentValue : Float;
	begin
		Put("Please insert ");
      	Put(matrix.rows,3);
      	Put('*');
        Put(matrix.cols,3);
		Put_Line(" entries row-wise:");
		for row in 1..matrix.rows loop
			for col in 1..matrix.cols loop
				Put(row,3);
				Put(',');
				Put(col,3);
				Put(": ");
				New_Line;
				Get(currentValue);
				matrix.content(row,col) := currentValue;
				New_Line;
			end loop;
		end loop;
		Put_Line("You entered:");
		Print(matrix);
	end Read;





begin
   --test init
   Put_Line("Test init:");
   Put_Line("Before:");
   Print(matrixX);
   Init(matrixX);
   Put_Line("After:");
   Print(matrixX);
   New_Line;
   Put_Line("---------------------------------");
   New_Line;

   --test addition
   Put_Line("Test addition:");
   Init(matrixA);
   Init(matrixB);
   matrixA.content(3,1) := 1.0;
   matrixB.content(3,1) := 2.0;

   Print(matrixA);
   Put_Line("+");
   Print(matrixB);
   Put_Line("=");
   matrixC := matrixA + matrixB;
   Print(matrixC);
   New_Line;
   Put_Line("---------------------------------");
   New_Line;

   --Test multiplication
   Put_Line("Test multiplication:");
   matrixD.content := matrixDContent;
   matrixE.content := matrixEContent;
   Print(matrixD);
   Put_Line("*");
   Print(matrixE);
   Put_Line("=");
   matrixF := matrixD * matrixE;
   Print(matrixF);

   --Test read
   Put_Line("Test read:");
   Read(matrixC);
end Matrix;
