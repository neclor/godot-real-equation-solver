@tool class_name TestLinear extends EditorScript




func _run() -> void:
	pass



func test_linear() -> void:
	assert(is_equal_approx_array(ResGenerator.linear(1), [1, -1]))
	verify_linear([1, -1], 1)
	verify_linear([0 ,0], NAN)

	for i in TEST_COUNT:
		var r: float = randf_value()
		var args: Array[float] = mul_array(ResGenerator.linear(r), randf_value_non_zero())
		verify_linear(args, r)


func verify_linear(args: Array[float], expected: float) -> void:
	var result: float = ResSolver.linear(args[0], args[1])
	if not (is_equal_approx(result, expected) or (is_nan(result) and is_nan(expected))):
		printerr("TEST: linear: args: {0}, result: {1}, expected: {2}".format([str(args), str(result), str(expected)]))
