extends Node2D

const SPAWN_EXPLOSION_SCENE = preload("res://Enemys/spwan_explosion.tscn")
const ENENY_SCENES = {
	"FLYING_ENEMY": preload("res://Enemys/flying_enemy.tscn")
}

var num_enemys

onready var tilemap = $Navigation2D/TileMap2
onready var entrance = $entrance
onready var door_container = $doors
onready var enemy_positions = $enemy_position
onready var player_detector = $player_detector


func _ready():
	num_enemys = enemy_positions.get_child_count()
	

func _on_enemy_killed():
	num_enemys -= 1
	if num_enemys == 0:
		_open_doors()
	
func _open_doors():
	for doors in door_container.get_children():
		doors.open()
	
func _close_entrance():
	for entrance_positon in entrance.get_children():
		tilemap.set_cellv(tilemap.world_to_map(entrance_positon.global_position), 2)
		tilemap.set_cellv(tilemap.world_to_map(entrance_positon.global_position) + Vector2.DOWN, 7)
		
func _spawn_enemys():
	for enemy_position in enemy_positions.get_children():
		var enemy = ENENY_SCENES.FLYING_ENEMY.instance()
		var __ = enemy.connect("tree_exited", self, "_on_enemy_killed")
		enemy.global_position = enemy_position.global_position
		call_deferred("add_child", enemy)
		
		var spawn_explosion = SPAWN_EXPLOSION_SCENE.instance()
		spawn_explosion.global_position = enemy_position.global_position
		call_deferred("add_child", spawn_explosion)


func _on_player_detector_body_entered(body):
	player_detector.queue_free()
	_close_entrance()
	_spawn_enemys()
