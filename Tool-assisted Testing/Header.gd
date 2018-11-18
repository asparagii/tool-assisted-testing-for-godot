extends HBoxContainer

var InputSequence = preload("sequence.gd")

var labels = []

func _ready():
	for i in InputSequence.Code:
		var element = Label.new()
		element.text = i
		element.align = ALIGN_CENTER
		element.valign = VALIGN_CENTER
		add_child(element)