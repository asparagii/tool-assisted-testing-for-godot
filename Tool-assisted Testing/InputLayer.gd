extends Node

# A day may come
# when dictionaries will be exported without issues
# but it is not this day

var InputSequence = preload("sequence.gd")

var sequences = []
var targets = []

var sceneSettings

func _ready():
	var customName = preload("UserSettings.gd").new().tatSettingsCustomName
	sceneSettings = find_node_recursive(get_tree().current_scene, customName)
	
	if sceneSettings != null and sceneSettings.mode == sceneSettings.Mode.TEST:
		for nodepath in sceneSettings.Characters:
			targets.append(sceneSettings.get_node(nodepath))
		for path in sceneSettings.TatFiles:
			var sequence = InputSequence.new(path)
			sequences.append(sequence)
			add_child(sequence)

func find_node_recursive(node, node_name):
	for N in node.get_children():
		if N.get_name() == node_name:
			return N
		else:
			if N.get_child_count() > 0:
				var result = find_node_recursive(N, node_name)
				if result != null:
					return result
	return null

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