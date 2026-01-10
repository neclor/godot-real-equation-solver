@abstract class_name _ResLogger extends RealEquationSolver


## Logger


static var _message_prefix: String = "[RealEquationSolver] - "


static func _push_warning(message: String = "") -> void:
	push_warning(_message_prefix + message)


static func _push_error(message: String = "") -> void:
	assert(false, _message_prefix + message)
	push_error(_message_prefix + message)


static func _check_number_array(module_name: String, method_name: String, array: Array) -> bool:
	for i in array:
		if i is int or i is float: continue
		_ResLogger._push_error("`" + module_name + "." + method_name + "`: Argument is not number: `" + i + "`. Returned [].")
		return false
	return true
