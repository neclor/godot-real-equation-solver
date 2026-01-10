@abstract class_name ResMath extends RealEquationSolver


## Math library


## Returns the cube root of [param x].
##
## [codeblock lang=gdscript]
## ResMath.cbrt(64) # Returns 4
## ResMath.cbrt(-27) # Returns -3
## [/codeblock]
static func cbrt(x: float) -> float:
	return signf(x) * absf(x) ** (1.0 / 3.0)


## Returns the cube of [param x].
##
## [codeblock lang=gdscript]
## ResMath.cube(3) # Returns 27
## [/codeblock]
static func cube(x: float) -> float:
	return x * x * x


## Returns the square of [param x].
##
## [codeblock lang=gdscript]
## ResMath.square(4) # Returns 16
## [/codeblock]
static func square(x: float) -> float:
	return x * x
