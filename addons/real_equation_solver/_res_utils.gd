@abstract class_name _ResUtils extends RealEquationSolver


## Utils


## Checks and returns a typed float array.
static func try_to_float_array(from: Array, out: Array[float]) -> bool:
	out.clear()
	for i in from:
		if not (i is int or i is float): return false

	out.append_array(from)
	return true
