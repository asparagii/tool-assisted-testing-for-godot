tool
extends EditorPlugin

var editor

func _enter_tree():
	editor = preload("tatEditor.tscn").instance()
	
	add_custom_type("InputLayer", "Node", preload("InputLayer.gd"), preload("icon.png"))
	add_control_to_dock(DOCK_SLOT_RIGHT_BL, editor)
	pass

func _exit_tree():
	remove_custom_type("InputLayer")
	remove_control_from_docks(editor)
	pass