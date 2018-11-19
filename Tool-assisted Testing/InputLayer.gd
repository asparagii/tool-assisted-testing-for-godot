extends Node

# A day may come
# when dictionaries will be exported without issues
# but it is not this day

var InputSequence = preload("sequence.gd")

var sequences = []
var targets = []

var sceneSettings

func _ready():
	sceneSettings = get_node(preload("UserSettings.gd").new().tatSettingsPath)
	
	if sceneSettings != null and sceneSettings.mode == sceneSettings.Mode.TEST:
		for nodepath in sceneSettings.Characters:
			targets.append(sceneSettings.get_node(nodepath))
		for path in sceneSettings.TatFiles:
			var sequence = InputSequence.new(path)
			sequences.append(sequence)
			add_child(sequence)

func is_action_pressed(action, caller):
	if sceneSettings != null and sceneSettings.mode == sceneSettings.Mode.TEST:
		var index = targets.find(caller)
		if index != -1:
			return sequences[index].is_action_pressed(action)
	
	return Input.is_action_pressed(action)

func is_action_just_pressed(action, caller):
	if sceneSettings != null and sceneSettings.mode == sceneSettings.Mode.TEST:
		var index = targets.find(caller)
		if index != -1:
			return sequences[index].is_action_just_pressed(action)
	
	return Input.is_action_just_pressed(action)