extends Character # inheretaing from the Character class

onready var sword = get_node("sword")
onready var sword_animation = sword.get_node("sword_attack")
onready var sword_hitbox = $sword/Node2D/sword/HitBox

func _process(delta):
	# storing the result of subtracking the global mouse position and the players global position
	# then normalizing it to get nicer numbers
	# (print get_global_mouse_position() and global_position to see what I mean the numbers are vary large)
	var mouse_direction = (get_global_mouse_position() - global_position).normalized()
	
	# if the players mouse is less that or grater than the players position (right around the middle of the players sprite)
	# then flip the player sprite to look towrd the mouse
	if mouse_direction.x > 0 and animated_sprite.flip_h:
		animated_sprite.flip_h = false
	elif mouse_direction.x < 0 and not animated_sprite.flip_h:
		animated_sprite.flip_h = true
		
	# sword.rotation stores the mouse_directions angle relative to the sword node
	sword.rotation = mouse_direction.angle() 
	sword_hitbox.knockback_direction = mouse_direction
	# print(sword.rotation)
	if sword.scale.y == 1 and  mouse_direction.x < 0:
		sword.scale.y = -1 
	elif sword.scale.y == -1 and  mouse_direction.x > 0:
		sword.scale.y = 1 
		
	

# This function handles the player input for moveing 
func get_input():
	# refrenaceing the mov_direction varable here so it dosent accumulate more values in the Vector
	mov_direction = Vector2.ZERO 
	
	# if Input.is_action_pressed() is checking for a keyboard input
	if Input.is_action_pressed("Down"):
		mov_direction += Vector2.DOWN # Vector2.DOWN looks like this Vector2(0,1)
	if Input.is_action_pressed("Left"):
		mov_direction += Vector2.LEFT # Vector2.LEFT looks like this Vector2(-1,0)
	if Input.is_action_pressed("Right"):
		mov_direction += Vector2.RIGHT # Vector2.RIGHT looks like this Vector2(1,0)
	if Input.is_action_pressed("Up"):
		mov_direction += Vector2.UP # Vector2.UP looks like this Vector2(0,1)
	# if the left mouse buton is clicked then the player will attack
	if Input.is_action_just_pressed("attack") and not sword_animation.is_playing():
		sword_animation.play("sword_attack")
	# when the player presses the Q button the will dash
	if Input.is_action_just_pressed("Dash"):
		#dash_dir()
		print("dash")
	
	
