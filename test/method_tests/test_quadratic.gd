class_name TestQuadratic extends TestTemplate


func _init() -> void:
	generator_method = ResGenerator.quadratic_array
	solver_method = ResSolver.quadratic_array
	roots_numbers = range(3)


func _run_specific_tests() -> void:
	TestUtils.verify(solver_method, [0, 0, 0], [])
	TestUtils.verify(solver_method, [0, 1, -1], [1])
	TestUtils.verify(solver_method, [1, 1, -6], [-3, 2])
