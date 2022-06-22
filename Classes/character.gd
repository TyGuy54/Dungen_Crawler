# this is a class for diffrent character to inherit from
# it inclues a lot of basic movement physics
# and taking damage logic
extends KinematicBody2D
class_name Character

const FRICTION = 0.15

export var hp = 4 setget set_hp
signal hp_changed(new_hp)

export var acceleration = 40
export var max_speed = 100

# getting he State_Machine node
onready var state_machine = $State_Machine
onready var animated_sprite = $AnimatedSprite

var mov_direction = Vector2.ZERO
var velocity = Vector2.ZERO


func _physics_process(delta):
	velocity = move_and_slide(velocity)
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)
	
func move():
	mov_direction = mov_direction.normalized()
	velocity += mov_direction * acceleration

#func dash_dir():
#	var dash_multiplier = -30
#	velocity.x += acceleration * dash_multiplier
	
# how every character will take damage
# it takes a damage, direction and a force parameter:
#	- damage is how much damage a player or enamy takes
#	- direction is in what direction a player or enemy will go when they get hit and die
#	- force is how far they will go when the die
func take_damage(damage, dir, force):
	self.hp -= damage
	if hp > 0:
		state_machine.set_state(state_machine.states.hurt)
		velocity += dir * force
	else:
		state_machine.set_state(state_machine.states.dead)
		velocity += dir * force * 2
		
func set_hp(new_hp):
	hp = new_hp
	emit_signal("hp_changed", new_hp)
	

