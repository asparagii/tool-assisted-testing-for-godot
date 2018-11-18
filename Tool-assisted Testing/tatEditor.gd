tool
extends VBoxContainer

var editingTarget = []

var InputSequence = preload("sequence.gd")

func _on_ChangeFile_pressed():
	get_node("LoadFileDialog").popup()

func _on_FileDialog_file_selected(path):
	loadTAT(path)
	init_grid()

func init_grid():
	get_node("Footer/AppendState").disabled = false
	get_node("Body/GridContainer").set_reference(self)
	get_node("Body/GridContainer").update()

func loadTAT(path):
	var file = File.new()
	file.open(path, File.READ)
	editingTarget = []
	while not file.eof_reached():
		editingTarget.append({
			"state": file.get_16(),
			"duration": file.get_float()
		})
	file.close()

func toggle_state(index, code):
	editingTarget[index].state = InputSequence.toggle(editingTarget[index].state, InputSequence.Code[code])
	get_node("Body/GridContainer").update()

func update_duration(value, index):
	editingTarget[index].duration = float(value)
	get_node("Body/GridContainer").update()

func _on_AppendState_pressed():
	editingTarget.append({
		"state": 0x0,
		"duration": 0.0
	})
	get_node("Body/GridContainer").update()

func saveTAT(path):
	var file = File.new()
	file.open(path, File.WRITE)
	for element in editingTarget:
		file.store_16(element.state)
		file.store_float(element.duration)
	file.close()
	

func _on_SaveFileDialog_file_selected(path):
	saveTAT(path)


func _on_SaveAs_pressed():
	get_node("SaveFileDialog").popup()


func _on_New_pressed():
	editingTarget = []
	init_grid()
