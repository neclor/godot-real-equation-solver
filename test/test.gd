@tool class_name Test extends EditorScript




func _run() -> void:
	#TestLinear.new().run_tests()
	TestQuadratic.new().run_tests()
	TestCubic.new().run_tests()
	TestQuartic.new().run_tests()
