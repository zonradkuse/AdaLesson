% Ada Exercise 2
% Christian Tabe <christian.tabe@rwth-aachen.de>
  Andreas Wüstenberg <andreas.wuestenberg@rwth-aachen.de>
  Johannes Neuhaus <johannes.neuhaus@rwth-aachen.de>

    
---
geometry: margin=1in
---

# Task 1

# Task 2

# Task 3

## a
Exceptions are automatically raised propagated a program's structure. In case a exception `e` is not handled in U, control leaves U nad might be handled here. If not, again, U is left and propagated through the program until the program terminates. This can be build with `goto` statements, too, but only in knowledge of the callstack.
When an exception is raised and it is not handled, there occurs a runtime error with information where the first entrance into the callstack was and where the respective raise statement is located. This information is hard to rebuild with `goto` statements. It even gets harder considering exception messages, which can be specified, too. Then a simple `goto` is not enough as no information can be passed to the handler without using global data structures.  

In a nutshell, exceptions are a much more modular solutions than `goto` statements.

## b
```Ada
with Ada.Text_IO;
use Ada.Text_IO;

procedure Navigation is -- main procedure embedding Position Calculation
    Position_Failure : exception;
    Navigation_Failure : exception;

    --
    -- Begin Mock
    --
    subtype Position_Type is Integer range 0..100;
    
    procedure Get_Position1 (Position : out Position_Type) is 

    begin
        Put_Line("Entered 1. Position is: " & Integer'Image(Position));
        raise Position_Failure;
    end Get_Position1;

    procedure Get_Position2 (Position : out Position_Type) is 

    begin
        Put_Line("Entered 2. Position is: " & Integer'Image(Position));
        raise Position_Failure;
    end Get_Position2;

    procedure Get_Position3 (Position : out Position_Type) is 

    begin
        Put_Line("Entered 3. Position is: " & Integer'Image(Position));
        raise Position_Failure;
    end Get_Position3;

    --
    -- End Mock
    --

    pos : Position_Type;

begin
    
    --
    -- Interesting Part!
    --
    begin
        Get_Position1(pos);
    exception
        when Position_Failure => 
            begin
                Get_Position2(pos);
            exception
                when Position_Failure =>
                    begin
                        Get_Position3(pos);
                    exception
                        when Position_Failure => 
                            Put_Line("Everything handled and we still failed. Raise Navigation_Failure");
                            raise Navigation_Failure;
                    end;
            end;
    end;

end Navigation;
```

# Task 4

## a

