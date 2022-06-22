extends Area2D
class_name HitBox

export var damage = 1
export var knockback_direction = Vector2.ZERO
export var knockback_force = 300

onready var collision_shape = get_child(0)

func _init():
	connect("body_entered", self, "_on_body_entered")
	
func ready():
	assert(collision_shape != null)
	
func _on_body_entered(body):
	body.take_damage(damage, knockback_direction, knockback_force)
