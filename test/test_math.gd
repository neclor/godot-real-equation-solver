@abstract class_name TestMath extends Object


static func is_equal_approx_array(a: Array[float], b: Array[float]) -> bool:
	if a.size() != b.size(): return false
	for i: int in a.size():
		if not is_equal_approx(a[i], b[i]): return false
	return true


static func is_equal_approx_one(a: float, b: float):
	return absf(a - b) < 1;


static func multiply_array(array: Array[float], x: float) -> Array[float]:
	return Array(array.map(func(i: float) -> float: return i * x), Variant.Type.TYPE_FLOAT, "", null)


static func randf_range_non_zero(from: float, to: float) -> float:
	var value: float = 0
	while is_zero_approx(value):
		value = randf_range(from, to)
	return value


static func randf_range_unique_values(from: float, to: float, amount: int = 1) -> Array[float]:
	var unique_values: Array[float] = []
	for i: int in amount:
		while true:
			var value: float = randf_range(from, to)
			if not unique_values.any(func(i: float) -> bool: return is_equal_approx(i, value) or is_equal_approx_one(i, value)):
				unique_values.append(value)
				break

	return unique_values
