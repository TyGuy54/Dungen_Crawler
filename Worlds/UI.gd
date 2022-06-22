extends CanvasLayer

const MIN_HEATH = 23
var max_hp = 4

onready var player = get_parent().get_node("player")
onready var health_bar = $HealthBar
onready var health_bar_tween = $HealthBar/Tween

func _ready():
	max_hp = player.hp
	_update_health(100)
	
	
func _update_health(new_value):
	var __ = health_bar_tween.interpolate_property(health_bar, 
	"value", health_bar.value, 
	new_value, 0.5, 
	Tween.TRANS_QUINT, Tween.EASE_OUT)
	
	__ = health_bar_tween.start()


func _on_player_hp_changed(new_hp):
	var new_health = int((100 - MIN_HEATH) * float(new_hp) / max_hp) + MIN_HEATH
	print(new_health)
	_update_health(new_health)
