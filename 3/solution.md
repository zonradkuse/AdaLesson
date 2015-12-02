% Ada Exercise 2
% Christian Tabe <christian.tabe@rwth-aachen.de>
  Andreas Wüstenberg <andreas.wuestenberg@rwth-aachen.de>
  Johannes Neuhaus <johannes.neuhaus@rwth-aachen.de>

    
---
geometry: margin=1in
---

# Task 1

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

# Task 2

# Task 3

`Matrix/Matrix.adb`


