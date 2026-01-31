extends Node

var player : Player
var player_spawned = false
const PLAYER = preload("uid://cg5do4pyqt1o6")


func _ready() -> void:
	add_player_instance()


func add_player_instance() -> void:
	player = PLAYER.instantiate()
	add_child(player)
	pass
	
func set_player_position(position : Vector2) -> void:
	print("setting player position")
	player.global_position = position
	
func set_as_parent(node : Node2D) -> void:
	if player.get_parent():
		player.get_parent().remove_child(player)
	node.add_child(player)

func unparent_player(node : Node2D) -> void:
	node.remove_child(player)
