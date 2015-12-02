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

# Task 2

# Task 3

`Matrix/Matrix.adb`


