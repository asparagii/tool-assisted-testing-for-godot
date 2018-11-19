tool
extends Control

var editingTarget = []

var InputSequence = preload("sequence.gd")
var action_table = preload("UserSettings.gd").new().action_table

func _on_ChangeFile_pressed():
	get_node("LoadFileDialog").popup()

func _on_FileDialog_file_selected(path):
	loadTAT(path)
	init_grid()

func init_grid():
	get_node("Container/Footer/AppendState").disabled = false
	get_node("Container/Body/GridContainer").set_reference(self)
	get_node("Container/Body/GridContainer").update()

func loadTAT(path):
	editingTarget = []
	var reader = InputSequence.new(path)
	while reader.next_state() != reader.EOF:
		editingTarget.append({
			"state": reader.state,
			"duration": reader.duration
		})

func toggle_state(index, action):
	editingTarget[index].state = InputSequence.toggle(editingTarget[index].state, action_table[action])
	get_node("Container/Body/GridContainer").update()

func update_duration(value, index):
	editingTarget[index].duration = float(value)
	get_node("Container/Body/GridContainer").update()

func delete_row(index):
	editingTarget.remove(index)
	get_node("Container/Body/GridContainer").update()

func _on_AppendState_pressed():
	editingTarget.append({
		"state": 0x0,
		"duration": 0.0
	})
	get_node("Container/Body/GridContainer").update()

func saveTAT(path):
	var file = File.new()
	file.open(path, File.WRITE)
	for element in editingTarget:
		file.store_32(element.state)
		file.store_float(element.duration)
	file.close()
	

func _on_SaveFileDialog_file_selected(path):
	saveTAT(path)

func _on_SaveAs_pressed():
	get_node("SaveFileDialog").popup()

func _on_New_pressed():
	editingTarget = []
	init_grid()