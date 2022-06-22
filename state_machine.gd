extends Node
class_name State_Machine

# This state machine is going to be an interface
# it wont have any inital functinality but will be instead inheritated
# checking some conditions and telling its parent what it should be doing

var state = -1 setget set_state
var previous_state = -1
var states = {}

onready var parent = get_parent()
onready var animation_player = parent.get_node("AnimationPlayer")

func _physics_process(delta):
	if state != -1:
		_state_logic(delta)
	var transition = _get_transition(delta)
	if transition != -1:
		set_state(transition)

func _state_logic(delta):
	pass
	
func _get_transition(delta):
	return null

func _enter_state(new_state, old_state):
	pass
	
func _exit_state(old_state, new_state):
	pass
	
func set_state(new_state):
	_exit_state(previous_state, new_state)
	previous_state = state
	state = new_state
	_enter_state(new_state, previous_state)
	
	
func add_states(state_name):
	states[state_name] = states.size()
