class_name TestQuartic extends TestTemplate


func _init() -> void:
	generator_method = ResGenerator.quartic_array
	solver_method = ResSolver.quartic_array
	roots_numbers = range(5)


func _run_specific_tests() -> void:
	super()
	verify([0, 0, 0, 0, 0], [])
	verify([0, 0, 0, 1, -1], [1])
	verify([1, -10, 35, -50, 24], [1, 2, 3, 4])
