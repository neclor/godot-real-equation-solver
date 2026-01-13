@abstract class_name TestUtils extends Object


static func verify(method: Callable, coeffs: Array[float], roots: Array[float]) -> void:
	var max_coeff: float = maxf(coeffs.max(), absf(coeffs.min()))
	if max_coeff >= TestConfig.INACCURACY_LIMIT: return

	roots.sort()

	var result: Array[float] = method.call(coeffs)
	if not TestMath.is_equal_approx_array(roots, result):
		printerr(method.get_method(), " - coeffs: ", coeffs, " result: ", result, " expected: ", roots)
