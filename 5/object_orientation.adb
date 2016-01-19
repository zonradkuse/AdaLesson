procedure object_orientation is

    type GraphObj is tagged record
        null;
    end record;

    type Line is new GraphObj with record
        a : Natural;
    end record;

    procedure paint (o : GraphObj) is
    begin
        null;
    end;

    l : Line := (a => 0);
begin
    paint(GraphObj(l));
end;
