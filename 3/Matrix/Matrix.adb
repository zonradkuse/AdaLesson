with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Numerics.Generic_Elementary_Functions;


procedure Matrix is
	package Float_Functions is new Ada.Numerics.Generic_Elementary_Functions (Float);
	use Float_Functions;


   	-- a)
   	type MatrixContent is array (Integer range <>, Integer range <>) of Float;
   	type MatrixRecord (rows: positive; cols: positive ) is record
      	--rows :  positive := r;
      	--cols : positive := c;
      	content : MatrixContent(1..rows, 1..cols);
   	end record;

   	--type for changing the sort algorithm
   	type T_SortAlgo_Access is access procedure (matrix : IN OUT MatrixRecord);

   --wrongFormatException : exception;
   	matrixX : MatrixRecord(3,4);
    matrixA : MatrixRecord(3,3);
    matrixB : MatrixRecord(3,3);

   	matrixC : MatrixRecord(3,3);
   	matrixD : MatrixRecord(2,3);
   	matrixE : MatrixRecord(3,2);
   	matrixF : MatrixRecord(2,2);

   	matrixS : MatrixRecord(3,3);

   	matrixDContent : MatrixContent := ((1.0,2.0,3.0),(4.0,5.0,6.0));
   	matrixEContent : MatrixContent := ((6.0,3.0),(5.0,2.0),(4.0,1.0));
   	matrixSContent : MatrixContent := ((5.0,9.0,7.0),(2.0,8.0,3.0),(4.0,6.0,1.0));



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

	--e)
	procedure ShearSort(matrix : IN OUT MatrixRecord) is
		-- non-static variable for setting bounds is not possible
		subtype T_Row is Integer range 1..matrix.rows;
		subtype T_Col is Integer range 1..matrix.cols;

		-- algorithm needs Log_2(n) + 1 phases where n is the number of elements
		-- ada rounds during conversion (2.5 -> 3), -0,5 is added to get a kind of cutoff
		phases : positive := Integer(Log(Float(matrix.rows*matrix.cols), 2.0) -0.5) + 1;

		-- all ascending
		procedure sortRow(row : T_Row) is
			temp : Float;
		begin
			-- bubble *_*
			for round in T_Col loop
				for index in 1..(T_Col'Last-1) loop
					if matrix.content(row,index) > matrix.content(row,index+1) then
						temp := matrix.content(row,index);
						matrix.content(row,index) := matrix.content(row,index+1);
						matrix.content(row,index+1) := temp;
					end if;
				end loop;
			end loop;
		end sortRow;

		--ascending
		procedure sortColAsc(col : T_Col) is
			temp : Float;
		begin
			-- bubble *_*
			for round in T_Row loop
					for index in 1..(T_Row'Last-1) loop
						if matrix.content(index, col) > matrix.content(index+1, col) then
							temp := matrix.content(index, col);
							matrix.content(index, col) := matrix.content(index +1 , col);
							matrix.content(index+1, col) := temp;
						end if;
					end loop;
				end loop;
		end sortColAsc;

		--descending
		procedure sortColDsc(col : T_Col) is
			temp : Float;
		begin
			-- bubble *_*
			for round in T_Row loop
					for index in 1..(T_Row'Last-1) loop
						if matrix.content(index, col) < matrix.content(index+1, col) then
							temp := matrix.content(index, col);
							matrix.content(index, col) := matrix.content(index +1 , col);
							matrix.content(index+1, col) := temp;
						end if;
					end loop;
				end loop;
		end sortColDsc;

		-- even cols : ascending
		-- odd cols descending
		procedure sortColShear(col : T_Col) is
		begin
			if (col mod 2 = 0) then
				SortColAsc(col); -- ascending
			else
				sortColDsc(col); -- descending
			end if;
		end sortColShear;

		procedure RowPhase is
		begin
			for I in T_Row loop
				sortRow(I);
			end loop;
		end RowPhase;

		procedure ColPhase is
		begin
			for I in T_Col loop
				sortColShear(I);
			end loop;
		end ColPhase;


	begin
		for I in 1..phases loop
			if (I mod 2 = 0) then
				ColPhase;
			else
				RowPhase;
			end if;
		end loop;
		-- the elements are in the correct collumn now
		for I in T_Col loop
			sortColAsc(I);
		end loop;
	end ShearSort;

	procedure Sort(matrix : IN OUT MatrixRecord; algo : T_SortAlgo_Access := ShearSort'Access) is

	begin
		algo(matrix);
	end Sort;



begin
--     Put_Line("Test init:");
--     Put_Line("Before:");
--     Print(matrixX);
--     Init(matrixX);
--     Put_Line("After:");
--     Print(matrixX);
--     New_Line;
--     Put_Line("---------------------------------");
--     New_Line;
--
--     --test addition
--     Put_Line("Test addition:");
--     Init(matrixA);
--     Init(matrixB);
--     matrixA.content(3,1) := 1.0;
--     matrixB.content(3,1) := 2.0;
--
--     Print(matrixA);
--     Put_Line("+");
--     Print(matrixB);
--     Put_Line("=");
--     matrixC := matrixA + matrixB;
--     Print(matrixC);
--     New_Line;
--     Put_Line("---------------------------------");
--     New_Line;
--
--     --Test multiplication
--     Put_Line("Test multiplication:");
--     matrixD.content := matrixDContent;
--     matrixE.content := matrixEContent;
--     Print(matrixD);
--     Put_Line("*");
--     Print(matrixE);
--     Put_Line("=");
--     matrixF := matrixD * matrixE;
--     Print(matrixF);
--
--     --Test read
--     Put_Line("Test read:");
--     Read(matrixC);

		-- test sort
		Put_Line("Test sort");
		matrixS.content := matrixSContent;
		Put_Line("Before:");
		Print(matrixS);
		Put_Line("After:");
		Sort(matrixS);
		Print(matrixS);

end Matrix;
