extends Enemy

onready var hitbox = $HitBox

func _process(delta):
	hitbox.knockback_direction = velocity.normalized()
