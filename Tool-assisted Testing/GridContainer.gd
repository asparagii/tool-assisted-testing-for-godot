tool
extends GridContainer

var InputSequence = preload("sequence.gd")
var userActionTable = preload("UserSettings.gd").new().action_table

var reference = null

func _ready():
	columns = len(userActionTable) + 2
	add_header()

func set_reference(object):
	reference = object

func update():
	reset_content()
	add_header()
	for element in reference.editingTarget:
		add_row(element)

func reset_content():
	for child in get_children():
		remove_child(child)

func add_header():
	"""Init header's labels, i.e. `UP`, `DOWN`, etc."""
	for code in userActionTable.keys():
		var label = Label.new()
		label.text = code
		add_child(label)
	var label = Label.new()
	label.text = "Duration"
	add_child(label)
	add_child(Control.new())

func add_row(element):
	var index = reference.editingTarget.find(element)
	for code in userActionTable.keys():
		var checkbox = CheckBox.new()
		checkbox.pressed = InputSequence.check(element.state, userActionTable[code])
		checkbox.connect("pressed", reference, "toggle_state", [index, code])
		add_child(checkbox)
	
	var lineEdit = LineEdit.new()
	lineEdit.text = String(element.duration)
	lineEdit.connect("text_entered", reference, "update_duration", [index])
	add_child(lineEdit)
	
	var deleteButton = Button.new()
	deleteButton.text = "Delete"
	deleteButton.connect("pressed", reference, "delete_row", [index])
	add_child(deleteButton)