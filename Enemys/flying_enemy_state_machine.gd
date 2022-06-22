extends State_Machine


func _init():
	add_states("chase")
	add_states("hurt")
	add_states("dead")
	
func _ready():
	set_state(states.chase)

func _state_logic(delta):
	if state == states.chase:
		parent.chase()
		parent.move()
		
func _get_transition(delta):
	match state:
		states.hurt:
			if not animation_player.is_playing():
				return states.chase
	return -1
	
func _enter_state(new_state, old_state):
	match new_state:
		states.chase:
			animation_player.play("fly")
		states.hurt:
			animation_player.play("hurt")
		states.dead:
			animation_player.play("dead")
		
	
