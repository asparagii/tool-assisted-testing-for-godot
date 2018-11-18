tool
extends HBoxContainer

var InputSequence = preload("sequence.gd")

var labels = []

func _ready():
	for i in InputSequence.Code:
		var element = CheckBox.new()
		element.align = ALIGN_CENTER
		add_child(element)