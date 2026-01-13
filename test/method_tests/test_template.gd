@abstract class_name TestTemplate extends RefCounted


var generator_method: Callable
var solver_method: Callable
var roots_numbers: Variant = []


func run_tests() -> void:
	_init()
	prints("Test", solver_method.get_method())
	_run_specific_tests()
	_run_regular_tests()
	print("")


func _init() -> void:
	pass


func _run_specific_tests() -> void:
	print("Specific test")


func _run_regular_tests() -> void:
	print("Regular test")
	for roots_number: int in roots_numbers:
		for i: int in TestConfig.TEST_COUNT:
			var roots: Array[float] = TestMath.randf_range_unique_values(-TestConfig.AMPLITUDE, TestConfig.AMPLITUDE, roots_number)
			var coeffs: Array[float] = generator_method.call(roots)
			coeffs = TestMath.multiply_array(coeffs, randf_range(-TestConfig.AMPLITUDE, TestConfig.AMPLITUDE))

			verify(coeffs, roots)


func verify(coeffs: Array[float], roots: Array[float]) -> void:
	var max_coeff: float = maxf(coeffs.max(), absf(coeffs.min()))
	if max_coeff >= TestConfig.INACCURACY_LIMIT: return

	roots.sort()

	var result: Array[float] = solver_method.call(coeffs)
	if not TestMath.is_equal_approx_array(roots, result):
		printerr(solver_method.get_method(), " - coeffs: ", coeffs, " result: ", result, " expected: ", roots)
