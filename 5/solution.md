% Ada Exercise 4
% Christian Tabe <christian.tabe@rwth-aachen.de>
  Andreas Wüstenberg <andreas.wuestenberg@rwth-aachen.de>
  Johannes Neuhaus <johannes.neuhaus@rwth-aachen.de>


---
geometry: margin=1in
---

# Object Orientation in Ada95

## a
Variant programming in Ada make use of variant records. They distinguish their
variants by using a discriminant instead of extending a "base" (tagged) record.  

Variant programming is nice when the cases, which need to be distinguished,
are really limited and it does not seem to be appropriate to use tagged records.
When the variants are unlimited or currently not known, variant records can
not replace tagged records. As soon as another variant of the record is needed,
a new record type is created.  
This approach is much cleaner than writing a new line of code into one
variant record.

## b

### polymorphism
```
Put('c');
Put("Hallo Welt!");
```
The function signature of `Put` differs in the parameters. Thus there is a
signature for Characters and one for Strings. This is the polymorphism.

### dynamic dispatch
For dynamic dispatching a class hierarchy is needed. The provided `Simple`
code example illustrates the use of this principle. 

## c
The Ada type system expects the type `GraphObj`. Although
`Line` is an extension to `GraphObj`, it is defined as own type and thus
can not be given to paint without a cast. The compiling code is given
in `object_orientation.adb`. Ada does not support automataic type casts.
