# RES - Real Equation Solver
Equation solver for finding real roots of equations up to 4th degree for Godot.

## Methods
```gdscript
float cbrt(x: float) static
float solve_linear(a: float, b: float) static
Array[float] solve_quadratic(a: float, b: float, c: float) static
Array[float] solve_cubic(a: float, b: float, c: float, d: float) static
Array[float] solve_quartic(a: float, b: float, c: float, d: float, e: float) static
```

## Example
```gdscript
func example() -> void:
	print(RES.cbrt(27)) # Prints 3
	print(RES.solve_linear(5, -10)) # Prints 2
	print(RES.solve_quadratic(1, 1, -6)) # Prints [-3, 2]
	print(RES.solve_cubic(2, -11, 12, 9)) # Prints [-0.5, 3]
	print(RES.solve_quartic(1, -10, 35, -50, 24)) # Prints [1, 2, 3, 4]
```
