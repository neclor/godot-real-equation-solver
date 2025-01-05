# Real Equation Solver
Equation solver for finding real roots of equations up to 4th degree for Godot.

## Methods
```gdscript
float cbrt(x: float)
float solve_linear(a: float, b: float)
Array[float] solve_quadratic(a: float, b: float, c: float)
Array[float] solve_cubic(a: float, b: float, c: float, d: float)
Array[float] solve_quartic(a: float, b: float, c: float, d: float, e: float)
```

## Example
```gdscript
RES.solve_cubic(2, -11, 12, 9) # Returns [-0.5, 3]
RES.solve_quartic(1, -10, 35, -50, 24) # Returns [1, 2, 3, 4]
```

## Warning
For large argument values, the answers may not be accurate or correct.
