# This is the Players state_machine, Unfortunatly I named it poorly 
# and renaming will cause a lot of wierd errors 
extends State_Machine

# this function will be initilized when this object is called
func _init():
	add_states("idle")
	add_states("move")
	add_states("hurt")
	add_states("dead")
	# add a dashing ablility to the player I think it would be fun!
	add_states('dash')
	
func _ready():
	set_state(states.idle)
	
func _state_logic(delta):
	if state == states.idle or states.move: # the player only moves if hes in the idle or moveing statess
		parent.get_input() # this is coming from the state_machine.gd script, its getting the paretn node(the player in this case)
		parent.move() # same as the above execpt this is in the Character class
		#parent.dash_dir()

# this function helps with transition in and out of diffrent states
func _get_transition(delta):
	match state:
		states.idle:
			if parent.velocity.length() > 10:
				return states.move
		states.move:
			if parent.velocity.length() < 10:
				return states.idle
		states.dash:
			if parent.velocity.length < 20:
				return states.dash
			if not animation_player.is_playing():
				return states.idle
		states.hurt:
			if not animation_player.is_playing():
				return states.idle
		
	return -1

func _enter_state(new_state, old_state):
	#print(new_state, ":", states)
	
	match new_state:
		states.idle:
			animation_player.play('idle')
		states.move:
			animation_player.play('move')
		states.hurt:
			animation_player.play('hurt')
		states.dash:
			print("dash")
			animation_player.play("dash")
		states.dead:
			animation_player.play("dead")
