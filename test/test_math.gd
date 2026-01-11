@abstract class_name TestMath extends Object


const EPSILON: float = 0.00001


static func is_equal_approx_array(a: Array[float], b: Array[float]) -> bool:
	if a.size() != b.size(): return false
	for i in a.size():
		if not is_equal_approx(a[i], b[i]): return false
	return true


static func is_equal_approx_epsilon(a: float, b: float, epsilon: float = EPSILON):
	if (a == b): return true
	var tolerance: float = EPSILON * abs(a);
	if tolerance < EPSILON: tolerance = EPSILON 
	return abs(a - b) < tolerance;


static func mul_array(array: Array[float], x: float) -> Array[float]:
	return Array(array.map(func(i: float) -> float: return i * x), Variant.Type.TYPE_FLOAT, "", null)



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
