tool
extends EditorPlugin

var editor

func _enter_tree():
	editor = preload("tatEditor.tscn").instance()
	add_custom_type("TATSettings", "Node", preload("TATSettings.gd"), preload("icon.png"))
	add_control_to_dock(DOCK_SLOT_RIGHT_BL, editor)
	pass

func _exit_tree():
	remove_custom_type("TATSettings")
	remove_control_from_docks(editor)
	pass