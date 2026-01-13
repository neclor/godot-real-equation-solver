class_name TestCubic extends TestTemplate


func _init() -> void:
	generator_method = ResGenerator.cubic_array
	solver_method = ResSolver.cubic_array
	roots_numbers = range(1, 4)


func _run_specific_tests() -> void:
	TestUtils.verify(solver_method, [0, 0, 0, 0], [])
	TestUtils.verify(solver_method, [0, 0, 1, -1], [1])
	TestUtils.verify(solver_method, [2, -11, 12, 9], [-0.5, 3])
	TestUtils.verify(solver_method, [-0.00000912074701, 0.00024175548471, 0.00522273431044, 0.01745862332987], [-10.5579491889302, -4.37511042269648, 41.4391653580114])
