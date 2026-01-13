@abstract class_name TestTemplate extends RefCounted


var generator_method: Callable
var solver_method: Callable
var roots_numbers: Variant = []


func run_tests() -> void:
	_init()
	prints(solver_method.get_method(), "test")
	_run_specific_tests()
	_run_regular_tests()
	print("")


func _init() -> void:
	pass


func _run_specific_tests() -> void:
	pass


func _run_regular_tests() -> void:
	for roots_number: int in roots_numbers:
		for i: int in TestConfig.TEST_COUNT:
			var roots: Array[float] = TestMath.randf_range_unique_values(-TestConfig.AMPLITUDE, TestConfig.AMPLITUDE, roots_number)
			var coeffs: Array[float] = generator_method.call(roots)
			coeffs = TestMath.multiply_array(coeffs, randf_range(-TestConfig.AMPLITUDE, TestConfig.AMPLITUDE))

			TestUtils.verify(solver_method, coeffs, roots)
