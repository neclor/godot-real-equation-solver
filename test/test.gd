@tool
extends EditorScript


const TEST_COUNT: int = 1000
const VALUE_AMPLITUDE: float = 1000


var rng: RandomNumberGenerator = RandomNumberGenerator.new()


func _run():
	print("RES Test")

	rng.randomize()
	prints("rng.seed =", rng.seed)

	test_cbrt()
	test_solve_linear()
	test_solve_quadratic()
	test_solve_cubic()
	test_solve_quartic()

	print("RES Test Completed")


#region Test cbrt

func test_cbrt() -> void:
	verify_cbrt(0, 0)
	for i in TEST_COUNT:
		var cube_root: float = randf_value_non_zero()
		var x: float = cube_root ** 3
		verify_cbrt(x, cube_root)


func verify_cbrt(x: float, cube_root: float) -> bool:
	var result: float = RES.cbrt(x)
	if is_equal_approx(result, cube_root): return true
	printerr("TEST: RES.cbrt({0}) returns: {1}, expected: {2}".format([str(x), str(result), str(cube_root)]))
	return false

#endregion


#region Test linear

func test_solve_linear() -> void:
	verify_solve_linear(0, 0, NAN)
	for i in TEST_COUNT:
		var root: float = randf_value()
		var a: float = randf_value_non_zero()
		var b: float = -(root * a)
		verify_solve_linear(a, b, root)


func verify_solve_linear(a: float, b: float, root: float) -> bool:
	var result: float = RES.solve_linear(a, b)
	if is_equal_approx(result, root) or (is_nan(result) and is_nan(root)): return true
	printerr("TEST: RES.solve_linear({0}, {1}) returns: {2}, expected: {3}".format([str(a), str(b), str(result), str(root)]))
	return false

#endregion


#region Test quadratic

func test_solve_quadratic() -> void:
	verify_solve_quadratic(0, 0, 0, [])
	test_solve_quadratic_zero_roots()
	test_solve_quadratic_one_root()
	test_solve_quadratic_two_roots()


func test_solve_quadratic_zero_roots() -> void:
	for i in TEST_COUNT:
		var a: float = randf_value_non_zero()
		var b: float = a
		var c: float = a
		verify_solve_quadratic(a, b, c, [])


func test_solve_quadratic_one_root() -> void:
	for i in TEST_COUNT:
		var root: float = randf_value()
		var a: float = randf_value_non_zero()
		var b: float = a * -2 * root
		var c: float = a * (root ** 2)
		verify_solve_quadratic(a, b, c, [root])


func test_solve_quadratic_two_roots() -> void:
	for i in TEST_COUNT:
		var roots: Array[float] = randf_unique_values(2)
		var a: float = randf_value_non_zero()
		var b: float = a * -(roots[0] + roots[1])
		var c: float = a * roots[0] * roots[1]
		verify_solve_quadratic(a, b, c, roots)


func verify_solve_quadratic(a: float, b: float, c: float, roots: Array[float]) -> bool:
	var result: Array[float] = RES.solve_quadratic(a, b, c)
	if is_equal_approx_arrays(result, roots): return true
	printerr("TEST: RES.solve_quadratic({0}, {1}, {2}) returns: {3}, expected: {4}".format([str(a), str(b), str(c), str(result), str(roots)]))
	return false

#endregion


#region Test cubic

func test_solve_cubic() -> void:
	verify_solve_cubic(0, 0, 0, 0, [])
	test_solve_cubic_one_root()
	test_solve_cubic_two_roots()
	test_solve_cubic_three_roots()


func test_solve_cubic_one_root() -> void:
	for i in TEST_COUNT:
		var root: float = randf_value()
		var a: float = randf_value_non_zero()
		var b: float = a * -root
		var c: float = a
		var d: float = a * -root
		verify_solve_cubic(a, b, c, d, [root])


func test_solve_cubic_two_roots() -> void:
	for i in TEST_COUNT:
		var roots: Array[float] = randf_unique_values(2)
		var a: float = randf_value_non_zero()
		var b: float = a * (-2 * roots[0] - roots[1])
		var c: float = a * ((roots[0] ** 2) + 2 * roots[0] * roots[1])
		var d: float = a * -(roots[0] ** 2) * roots[1]
		verify_solve_cubic(a, b, c, d, roots)


func test_solve_cubic_three_roots() -> void:
	for i in TEST_COUNT:
		var roots: Array[float] = randf_unique_values(3)
		var a: float = randf_value_non_zero()
		var b: float = a * -(roots[0] + roots[1] + roots[2])
		var c: float = a * (roots[0] * roots[1] + roots[0] * roots[2] + roots[1] * roots[2])
		var d: float = a * -(roots[0] * roots[1] * roots[2])
		verify_solve_cubic(a, b, c, d, roots)


func verify_solve_cubic(a: float, b: float, c: float, d: float, roots: Array[float]) -> bool:
	var result: Array[float] = RES.solve_cubic(a, b, c, d)
	if is_equal_approx_arrays(result, roots): return true
	printerr("TEST: RES.solve_cubic({0}, {1}, {2}, {3}) returns: {4}, expected: {5}".format([str(a), str(b), str(c), str(d), str(result), str(roots)]))
	return false

#endregion


#region Test quadratic

func test_solve_quartic() -> void:
	verify_solve_quartic(0, 0, 0, 0, 0, [])
	test_solve_quartic_zero_roots()
	test_solve_quartic_one_root()
	test_solve_quartic_two_roots()
	test_solve_quartic_three_roots()
	test_solve_quartic_four_roots()


func test_solve_quartic_zero_roots() -> void:
	for i in TEST_COUNT:
		var a: float = randf_value_non_zero()
		var b: float = a
		var c: float = a
		var d: float = a
		var e: float = a
		verify_solve_quartic(a, b, c, d, e, [])


func test_solve_quartic_one_root() -> void:
	for i in TEST_COUNT:
		var root: float = randf_value()
		var a: float = randf_value_non_zero()
		var b: float = a * -2 * root
		var c: float = a * ((root ** 2) + 1)
		var d: float = a * -2 * root
		var e: float = a * (root ** 2)
		verify_solve_quartic(a, b, c, d, e, [root])


func test_solve_quartic_two_roots() -> void:
	for i in TEST_COUNT:
		var roots: Array[float] = randf_unique_values(2)
		var a: float = randf_value_non_zero()
		var b: float = a * -(roots[0] + roots[1])
		var c: float = a * (roots[0] * roots[1] + 1)
		var d: float = a * -(roots[0] + roots[1])
		var e: float = a * roots[0] * roots[1]
		verify_solve_quartic(a, b, c, d, e, roots)


func test_solve_quartic_three_roots() -> void:
	for i in TEST_COUNT:
		var roots: Array[float] = randf_unique_values(3)
		var a: float = randf_value_non_zero()
		var b: float = a * -(2 * roots[0] + roots[1] + roots[2])
		var c: float = a * ((roots[0] ** 2) + 2 * roots[0] * roots[1] + 2 * roots[0] * roots[2] + roots[1] * roots[2])
		var d: float = a * -((roots[0] ** 2) * roots[1] + (roots[0] ** 2) * roots[2] + 2 * roots[0] * roots[1] * roots[2])
		var e: float = a * (roots[0] ** 2) * roots[1] * roots[2]
		verify_solve_quartic(a, b, c, d, e, roots)


func test_solve_quartic_four_roots() -> void:
	for i in TEST_COUNT:
		var roots: Array[float] = randf_unique_values(4)
		var a: float = randf_value_non_zero()
		var b: float = a * -(roots[0] + roots[1] + roots[2] + roots[3])
		var c: float = a * (roots[0] * roots[1] + roots[0] * roots[2] + roots[0] * roots[3] + roots[1] * roots[2] + roots[1] * roots[3] + roots[2] * roots[3])
		var d: float = a * -(roots[0] * roots[1] * roots[2] + roots[0] * roots[1] * roots[3] + roots[0] * roots[2] * roots[3] + roots[1] * roots[2] * roots[3])
		var e: float = a * roots[0] * roots[1] * roots[2] * roots[3]
		verify_solve_quartic(a, b, c, d, e, roots)


func verify_solve_quartic(a: float, b: float, c: float, d: float, e: float, roots: Array[float]) -> bool:
	var result: Array[float] = RES.solve_quartic(a, b, c, d, e)
	if is_equal_approx_arrays(result, roots): return true
	printerr("TEST: RES.solve_quartic({0}, {1}, {2}, {3}, {4}) returns: {5}, expected: {6}".format([str(a), str(b), str(c), str(d), str(e), str(result), str(roots)]))
	return false

#endregion


#region Utils

func randf_value() -> float:
	return rng.randf_range(-VALUE_AMPLITUDE, VALUE_AMPLITUDE)


func randf_value_non_zero() -> float:
	while true:
		var value: float = randf_value()
		if not is_zero_approx(value): return value
	return 1


func randf_unique_values(amount: int) -> Array[float]:
	var unique_values: Array[float] = []
	for i in amount:
		while true:
			var new_value: float = randf_value()
			var new_value_is_unique: bool = true
			for unique_value in unique_values:
				if is_equal_approx(new_value, unique_value):
					new_value_is_unique = false
					break
			if new_value_is_unique:
				unique_values.append(new_value)
				break
	unique_values.sort()
	return unique_values


func is_equal_approx_arrays(a: Array[float], b: Array[float]) -> bool:
	if a.size() != b.size(): return false
	for i in a.size():
		if not is_equal_approx(a[i], b[i]): return false
	return true

#endregion
