extends Node

# A day may come
# when dictionaries will be exported without issues
# but it is not this day

enum Modes {NORMAL, TEST}

var InputSequence = preload("sequence.gd")

export(Array, NodePath) var Targets
export(Array, String) var SequenceFilePaths
export(Modes) var Mode

var sequences = []
var targets = []

func _enter_tree():
	if Mode != TEST:
		return

	for nodepath in Targets:
		targets.append(get_node(nodepath))
	for path in SequenceFilePaths:
		var sequence = InputSequence.new(path)
		sequences.append(sequence)
		add_child(sequence)

func is_action_pressed(action, caller):
	if Mode == TEST:
		var index = targets.find(caller)
		if index != -1:
			return sequences[index].is_action_pressed(action)
	
	return Input.is_action_pressed(action)

func is_action_just_pressed(action, caller):
	if Mode == TEST:
		var index = targets.find(caller)
		if index != -1:
			return sequences[index].is_action_just_pressed(action)
	
	return Input.is_action_just_pressed(action)