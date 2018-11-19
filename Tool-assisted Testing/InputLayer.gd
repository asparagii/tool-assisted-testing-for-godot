extends Node

# A day may come
# when dictionaries will be exported without issues
# but it is not this day

var InputSequence = preload("sequence.gd")

var sequences = []
var targets = []

var customname 
var sceneSettings

func _ready():
	customname = preload("UserSettings.gd").new().tatSettingsCustomName
	find_tatsettings_from_(get_tree().current_scene)
	
	if sceneSettings != null and sceneSettings.mode == sceneSettings.Mode.TEST:
		for nodepath in sceneSettings.Characters:
			targets.append(sceneSettings.get_node(nodepath))
		for path in sceneSettings.TatFiles:
			var sequence = InputSequence.new(path)
			sequences.append(sequence)
			add_child(sequence)

func find_tatsettings_from_(node):
	for N in node.get_children():
		if N.get_child_count() > 0:
			if N.get_name() == customname:
				sceneSettings = N
			find_tatsettings_from_(N)
		else:
			#print("-" + N.get_name())
			if N.get_name() == customname:
				sceneSettings = N
			pass

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