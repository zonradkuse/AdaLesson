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

# Task 4

