tool
extends GridContainer

var InputSequence = preload("sequence.gd")

var reference = null

func _ready():
	columns = len(InputSequence.Code) + 1
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
	for code in InputSequence.Code:
		var label = Label.new()
		label.text = code
		add_child(label)
	var label = Label.new()
	label.text = "Duration"
	add_child(label)

func add_row(element):
	var index = reference.editingTarget.find(element)
	for code in InputSequence.Code:
		var checkbox = CheckBox.new()
		checkbox.pressed = InputSequence.check(element.state, InputSequence.Code[code])
		checkbox.connect("pressed", reference, "toggle_state", [index, code])
		add_child(checkbox)
	
	var lineEdit = LineEdit.new()
	lineEdit.text = String(element.duration)
	lineEdit.connect("text_entered", reference, "update_duration", [index])
	add_child(lineEdit)
	