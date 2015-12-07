% Ada Exercise 2
% Christian Tabe <christian.tabe@rwth-aachen.de>
  Andreas Wüstenberg <andreas.wuestenberg@rwth-aachen.de>
  Johannes Neuhaus <johannes.neuhaus@rwth-aachen.de>

    
---
geometry: margin=1in
---

# Task 1

## access types 

```Ada
type IntAccess is access Integer;
```
Pointer to an Integer on the heap. A simple access type cannot point to an
stack object.  

```Ada
type IntAccessAll is access all Integer;
```
Pointer to an Integer. Maybe on the Stack or on library (static) level. This 
kind of pointer provides *read-write* access.  

```Ada
type IntAccessConst is access constant Integer;
```
Pointer to an Integer. Maybe on the Stack or on library (static) level. This 
kind of pointer provides *read-only* access.  

## aliased
In order to reference a variable with an access type, it must be declared 
`aliased`. As a Variable is usually located on the stack if not instantiated 
explicitly otherwise. `aliased constant` disallows write access to the 
underlying variable.  

## assignments
### 1
*valid* as this is a assignment between integers. 

### 2
*valid* as c is aliased.

### 3
*valid* (see 1)

### 4
*valid* since b is aliased and the constant restriction on r simply restricts
access through r to reading only, but this is a smaller access permission as
granted by b.

### 5
*not valid* as it is an assignment of a constant

### 6
*not valid* since the new integer itself is not constant. 

### 7
*not valid* as this is a assignment of a pointer to a Integer variable.

### 8
*not valid* since r is a read-only access.

### 9
*not valid* as a is not an aliased variable.

### 10
*not valid* since b resides on the stack and p is not of the kind `access all`

### 11
*not valid* as this is an assignment of two different types

### 12
*not valid* since q is not aliased.

## b
By using access types - or pointers in general - it is not clear where 
the data is really manipulated. Only the address is passed to the function
and it is no longer necessary to assign some return value to the 
manipulated variable. This can surely be compared with gotos as one could jump
into a manipulating section and back again.
Even worse: the manipulating method deallocates the memory and produces 
that way a so called dangling reference. The referenced data could be set 
to `null`, too, which is of course bad when a developer tried to find out 
where the value was set to `null`.  

With great power comes great responsibility (lol, spiderman). When pointers
are used in a clear and "contracted" fashion, they can be really helpful. 
Imagine a huge matrix (a few 100k entries). Not passing the matrix's 
reference into a method causes an unnecessary deep-copy. The same holds 
for gotos. Gotos are heavily used in parsers/compilers (and the *nix kernel 
- but this is some really weird piece of software) as they provide a 
nice and understandable way to build state machines.    

Ada gives some helpers when dealing with access types:  

 - `not null` keyword when declaring access types in order to indicate that the
content must not be null.
 - deallocating memory of a pointer in a nested method is forbidden 
and dangling references are thus prevented.  

# Task 2
Subprograms as parameter (or callbacks) could expand the scope of the calling 
procedure artificially. The subprogram, which is used as a parameter, has to be visible to the calling procedure.
So if they are in different packages for example, you have to make clear that the subprogram can be called from other packages.

Furthermore the readability is worse for small programs like shown below.

```Ada
procedure main is -- this is not meant to be compiling, just to give an idea
    procedure test (cb : access procedure(id : Integer));
    
    procedure problem 
    is
        procedure mycb ( id : Integer);
    begin
        test(mycb'Access);
    end problem;
begin
    problem;
end main;
```

Using subprograms can be a very convenient way dealing with asynchronous 
behaviour or implementing frameworks. Frameworks could be easily implemented 
by giving the developer an interface where methods can be registered. 
Javascript makes heavy use of this which leads to so called 
"callback hells" quite often. There are some workarounds which make this a 
little handier but is sometimes still considered as unintuitive code. This
shows that the usage of such a feature should be well considered. (In the case 
of js callbacks the only deliberate way dealing with async tasks are 
callbacks, indeed).  

# Task 3

`Matrix/Matrix.adb`


