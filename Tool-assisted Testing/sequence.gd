extends Node

var file
var state = 0x0
var pState = 0x0
var duration = 0.0
var elapsedTime = 0.0

enum {EOF, CONTINUE}

onready var nametable = preload("UserSettings.gd").new().action_table

func get_action_code_from(actionName):
	return nametable[actionName]

func _init(filepath):
	file = File.new()
	file.open(filepath, File.READ)

func _process(delta):
	pState = state
	elapsedTime += delta
	if elapsedTime > duration:
		next_state()
		elapsedTime = 0

func next_state():
	state = file.get_32()
	duration = file.get_float()
	return EOF if file.eof_reached() else CONTINUE

func is_action_pressed(action):
	var code = get_action_code_from(action)
	return check(state, code)

func is_action_just_pressed(action):
	var code = get_action_code_from(action)
	return check(state, code) and not check(pState, code)

func is_action_just_released(action):
	var code = get_action_code_from(action)
	return check(pState, code) and not check(state, code)

static func check(state, code):
	return (state & (1 << code)) > 0

static func toggle(state, code):
	return state ^ (1 << code)

static func turn_on(state, code):
	return state | (1 << code)

static func turn_off(state, code):
	return state & ~(1 << code)
