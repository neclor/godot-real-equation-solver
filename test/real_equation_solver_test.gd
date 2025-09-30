@tool
class_name RealEquationSolverTest extends EditorScript


const TEST_COUNT: int = 1000
const VALUE_AMPLITUDE: float = 100


var rng: RandomNumberGenerator = RandomNumberGenerator.new()


func _run() -> void:
	print("Real Equation Solver Test")

	rng.randomize()
	prints("rng.seed =", rng.seed)

	test_cbrt()
	test_linear()
	test_quadratic()
	test_cubic()
	test_quartic()

	print("Res Test Completed")


#region Test Cbrt
func test_cbrt() -> void:
	assert(RealEquationSolverMath.cbrt(27) == 3)
	verify_cbrt(0, 0)

	for i in TEST_COUNT:
		var cbrt_x: float = randf_value_non_zero()
		verify_cbrt(cbrt_x * cbrt_x * cbrt_x, cbrt_x)


func verify_cbrt(x: float, cbrt_x: float) -> void:
	var result: float = RealEquationSolverMath.cbrt(x)
	if not is_equal_approx(result, cbrt_x):
		printerr("TEST: cbrt: arg: {0}, returns: {1}, expected: {2}".format([str(x), str(result), str(cbrt_x)]))
#endregion


#region Test Linear
func test_linear() -> void:
	assert(is_equal_approx_array(Reg.linear(1), [1, -1]))
	verify_linear([1, -1], 1)
	verify_linear([0 ,0], NAN)

	for i in TEST_COUNT:
		var r: float = randf_value()
		var args: Array[float] = mul_array(Reg.linear(r), randf_value_non_zero())
		verify_linear(args, r)


func verify_linear(args: Array[float], expected: float) -> void:
	var result: float = Res.linear(args[0], args[1])
	if not (is_equal_approx(result, expected) or (is_nan(result) and is_nan(expected))):
		printerr("TEST: linear: args: {0}, result: {1}, expected: {2}".format([str(args), str(result), str(expected)]))
#endregion


#region Test Quadratic
func test_quadratic() -> void:
	assert(is_equal_approx_array(Reg.quadratic(1, 2), [1, -3, 2]))
	verify_quadratic([1, -3, 2], [1, 2])
	verify_quadratic([0, 0, 0], [])

	test_quadratic_zero_roots()
	test_quadratic_one_root()
	test_quadratic_two_roots()


func test_quadratic_zero_roots() -> void:
	for i in TEST_COUNT:
		var a: float = randf_value_non_zero()
		verify_quadratic([a, a, a], [])


func test_quadratic_one_root() -> void:
	for i in TEST_COUNT:
		var r: Array[float] = randf_unique_values(1)
		var args: Array[float] = mul_array(Reg.quadratic(r[0], r[0]), randf_value_non_zero())
		verify_quadratic(args, r)


func test_quadratic_two_roots() -> void:
	for i in TEST_COUNT:
		var r: Array[float] = randf_unique_values(2)
		var args: Array[float] = mul_array(Reg.quadratic(r[0], r[1]), randf_value_non_zero())
		verify_quadratic(args, r)


func verify_quadratic(args: Array[float], expected: Array[float]) -> void:
	var result: Array[float] = Res.quadratic(args[0], args[1], args[2])
	if not is_equal_approx_array(result, expected):
		printerr("TEST: quadratic: args: {0}, result: {1}, expected: {2}".format([str(args), str(result), str(expected)]))
#endregion


#region Test Cubic
func test_cubic() -> void:
	assert(is_equal_approx_array(Reg.cubic(1, 2, 3), [1, -6, 11, -6]))
	verify_cubic([1, -6, 11, -6], [1, 2, 3])
	verify_cubic([0, 0, 0, 0], [])

	test_cubic_one_root()
	test_cubic_two_roots()
	test_cubic_three_roots()


func test_cubic_one_root() -> void:
	for i in TEST_COUNT:
		var r: Array[float] = randf_unique_values(1)
		var args: Array[float] = mul_array(Reg.cubic(r[0], r[0], r[0]), randf_value_non_zero())
		verify_cubic(args, r)


func test_cubic_two_roots() -> void:
	for i in TEST_COUNT:
		var r: Array[float] = randf_unique_values(2)
		var args: Array[float] = mul_array(Reg.cubic(r[0], r[0], r[1]), randf_value_non_zero())
		verify_cubic(args, r)


func test_cubic_three_roots() -> void:
	for i in TEST_COUNT:
		var r: Array[float] = randf_unique_values(3)
		var args: Array[float] = mul_array(Reg.cubic(r[0], r[1], r[2]), randf_value_non_zero())
		verify_cubic(args, r)


func verify_cubic(args: Array[float], expected: Array[float]) -> void:
	var result: Array[float] = Res.cubic(args[0], args[1], args[2], args[3])
	if not is_equal_approx_array(result, expected): 
		printerr("TEST: cubic: args: {0}, result: {1}, expected: {2}".format([str(args), str(result), str(expected)]))
#endregion


#region Test Quartic
func test_quartic() -> void:
	assert(is_equal_approx_array(Reg.quartic(1, 2, 3, 4), [1, -10, 35, -50, 24]))
	verify_quartic([1, -10, 35, -50, 24], [1, 2, 3, 4])
	verify_quartic([0, 0, 0, 0, 0], [])

	test_quartic_zero_roots()
	test_quartic_one_root()
	test_quartic_two_roots()
	test_quartic_three_roots()
	test_quartic_four_roots()


func test_quartic_zero_roots() -> void:
	for i in TEST_COUNT:
		var a: float = randf_value_non_zero()
		verify_quartic([a, a, a, a, a], [])


func test_quartic_one_root() -> void:
	for i in TEST_COUNT:
		var r: Array[float] = randf_unique_values(1)
		var args: Array[float] = mul_array(Reg.quartic(r[0], r[0], r[0], r[0]), randf_value_non_zero())
		verify_quartic(args, r)


func test_quartic_two_roots() -> void:
	for i in TEST_COUNT:
		var r: Array[float] = randf_unique_values(2)
		var args: Array[float] = mul_array(Reg.quartic(r[0], r[0], r[1], r[1]), randf_value_non_zero())
		verify_quartic(args, r)


func test_quartic_three_roots() -> void:
	for i in TEST_COUNT:
		var r: Array[float] = randf_unique_values(3)
		var args: Array[float] = mul_array(Reg.quartic(r[0], r[0], r[1], r[2]), randf_value_non_zero())
		verify_quartic(args, r)


func test_quartic_four_roots() -> void:
	for i in TEST_COUNT:
		var r: Array[float] = randf_unique_values(4)
		var args: Array[float] = mul_array(Reg.quartic(r[0], r[1], r[2], r[3]), randf_value_non_zero())
		verify_quartic(args, r)


func verify_quartic(args: Array[float], expected: Array[float]) -> void:
	var result: Array[float] = Res.quartic(args[0], args[1], args[2], args[3], args[4])
	if not is_equal_approx_array(result, expected):
		printerr("TEST: quartic: args: {0}, result: {1}, expected: {2}".format([str(args), str(result), str(expected)]))
#endregion


#region Array
func is_equal_approx_array(a: Array[float], b: Array[float]) -> bool:
	if a.size() != b.size(): return false
	for i in a.size():
		if not (is_equal_approx(a[i], b[i]) or is_diff_less_than_one(a[i], b[i])): return false
	return true


func mul_array(array: Array[float], x: float) -> Array[float]:
	return Array(array.map(func(i: float) -> float: return i * x), TYPE_FLOAT, "", null)
#endregion


#region Rand
func randf_value() -> float:
	return rng.randf_range(-VALUE_AMPLITUDE, VALUE_AMPLITUDE)


func randf_value_non_zero() -> float:
	var value: float = 0
	while is_zero_approx(value): value = randf_value()
	return value


func randf_unique_values(amount: int) -> Array[float]:
	var unique_values: Array[float] = []
	for i in amount:
		while true:
			var new_value: float = randf_value()
			var new_value_is_unique: bool = true
			for value in unique_values:
				if is_equal_approx(new_value, value) or is_diff_less_than_one(new_value, value):
					new_value_is_unique = false
					break
			if new_value_is_unique:
				unique_values.append(new_value)
				break
	unique_values.sort()
	return unique_values


func is_diff_less_than_one(a: float, b: float) -> bool:
	return absf(a - b) < 1
#endregion
