class_name TestLinear extends TestTemplate


func _init() -> void:
	generator_method = ResGenerator.linear_array
	solver_method = ResSolver.linear_array
	roots_numbers = range(1, 1)


func _run_specific_tests() -> void:
	super()
	verify([0, 1], [NAN])
	verify([5, -10], [2])


func verify(coeffs: Array[float], roots: Array[float]) -> void:
	var max_coeff: float = maxf(coeffs.max(), absf(coeffs.min()))
	if max_coeff >= TestConfig.INACCURACY_LIMIT: return

	roots.sort()

	var result: Array[float] = [solver_method.call(coeffs)]
	if not TestMath.is_equal_approx_array(roots, result):
		printerr(solver_method.get_method(), " - coeffs: ", coeffs, " result: ", result, " expected: ", roots)
