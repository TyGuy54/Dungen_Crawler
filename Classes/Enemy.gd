extends Character
class_name Enemy

# PoolVector2Array: An Array specifically designed to hold Vector2. 
# Optimized for memory usage, does not fragment the memory.
var path: PoolVector2Array 

# two varabales that hold the vales of two node:
#	- Navigation2D
#	- player
# This is so the enemy knows where the player is and what tile has navigation
onready var navigation = get_parent().get_node("Navigation2D")
onready var player = get_tree().current_scene.get_node("player")
onready var path_timer = $path_timer

# this funcion has the flying enemies chase logic
func chase():
	if path:
		var vector_to_next_point = path[0] - global_position # getting the first value in the path array of vectors
		var distance_to_next_point = vector_to_next_point.length() # getting the intire length of vector_to_next_point
		if distance_to_next_point < 5: # if the distance_to_next_point is greater than 3 then remove the first vector then reset to the mov_direction 
			path.remove(0)
			if not path:
				return
		mov_direction = vector_to_next_point
		
		# this code is for flipping the sprite if the x position of the vector_to_next_point
		# is less then or greater that 0
		if vector_to_next_point.x > 0 and animated_sprite.flip_h:
			animated_sprite.flip_h = false
		elif vector_to_next_point.x < 0 and not animated_sprite.flip_h:
			animated_sprite.flip_h = true

# a  signal connected to the timer node for reseting the enemies navigation
func _on_path_timer_timeout():
	if is_instance_valid(player): # checking if the player is a valid instance before the enemy makes a new path
		path = navigation.get_simple_path(global_position, player.position)
	else:
		path_timer.stop()
		path = []
		mov_direction = Vector2.ZERO
