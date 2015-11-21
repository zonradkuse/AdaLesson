% Ada Exercise 1
% Johannes Neuhaus <johannes.neuhaus@rwth-aachen.de>

---
geometry: margin=1in
---


## 1.1
`with Ex1.Hello_World`

## 1.2

### `a`
Ada divides a program's structure into a declarative part and a second logical part, which must not contain any declarations. `with` and `use` statements are declarative and therefor contained by the wrong section. Of couse x should be declared first, too.

### `b`
```Ada
loop 
	S1;
	loop
		S2;
		exit when B1;
	end loop;
end loop;
```




