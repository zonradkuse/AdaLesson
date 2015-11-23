procedure test is
    type Hour_Number_Type is range 1..12;
    subtype Late_Hour_Number_Type is Hour_Number_Type range 7..12;
    type Month_Number_Type is range 1..12;
    subtype Late_Month_Number_Type is Month_Number_Type range 7..12;
    type One_To_Twelve_Type is range 1..12;
    Hour_Number : Hour_Number_Type;
    Late_Hour_Number : Late_Hour_Number_Type;
    Month_Number : Month_Number_Type;
    Late_Month_Number : Late_Month_Number_Type;
    One_To_Twelve : One_To_Twelve_Type;

    --type Week_Number_Type is new Integer range 1..52;
    type Week_Number_Type is range 1..52;
    --subtype Week_Number_Type is Integer range 1..52;

    type R (J: positive) is record
        S: String (1..J);
    end record;
    A: array(1..10) of R(100);

type Car (wheelcount : positive := 4) is
    record
         wheels : Integer := wheelcount;
         axis : Integer := wheelcount/2;
    end record;
begin -- test
    Hour_Number := Late_Hour_Number;
    Late_Hour_Number := Hour_Number;
    --Hour_Number := Month_Number;
    Month_Number := Late_Month_Number;
    --Hour_Number := Late_Month_Number;
    --One_To_Twelve := Hour_Number;
end test;