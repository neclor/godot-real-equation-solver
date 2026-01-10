@tool
extends EditorScript









func _run() -> void:
	print(null)
	print(ResSolver.solve(1, 2, 3))




func abc(...a) -> float:
	print(a)
	print(a.all(func(i): return i is float or i is int))
	
	print("a ", a)

	var sum: float = 0
	
	for i in a:
		sum += i

	return sum
