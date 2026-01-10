@abstract class_name _ResLogger extends RealEquationSolver


## Logger


static var _message_prefix: String = "[RealEquationSolver] - "


## Push error.
static func error(message: String = "") -> void:
	assert(false, _message_prefix + message)
	push_error(_message_prefix + message)


## Format and push error.
static func format_error(module: String, method: String, message: String, returned: bool = false, return_value: Variant = "") -> void:
	error(format_message(module, method, message, returned, return_value))


## Format message.
static func format_message(module: String, method: String, message: String, returned: bool = false, return_value: Variant = "") -> String:
	return "`%s.%s`: %s." % [module, method, message] + (" Returned " + return_value + ".") if returned else ""


## Format and push warning.
static func format_warning(module: String, method: String, message: String, returned: bool = false, return_value: Variant = "") -> void:
	warning(format_message(module, method, message, returned, return_value))


## Push warning.
static func warning(message: String = "") -> void:
	push_warning(_message_prefix + message)
