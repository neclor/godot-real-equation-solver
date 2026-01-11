@tool
class_name TTTTS extends EditorScript









func _run() -> void:

	_ResLogger.format_error(TTTTS, _run, "Test", [])
	
	match [1, 2, 3, 4, 5].size():


		
		var i when i > 4:
			print("aaaa")
			
		_:
			print("i")
	
	


func abc(...a) -> float:
	print(a)
	print(a.all(func(i): return i is float or i is int))
	
	print("a ", a)

	var sum: float = 0
	
	for i in a:
		sum += i

	return sum



	
