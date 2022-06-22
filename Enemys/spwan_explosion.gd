extends AnimatedSprite

func _ready():
	playing = true


func _on_spwan_explosion_animation_finished():
	queue_free()
