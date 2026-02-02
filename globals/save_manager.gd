extends Node

const SAVE_PATH = "user://game.sav"

signal game_loaded
signal game_saved

var current_save : Dictionary = {
	scene_path = "",
	player = {
		hp = 1,
		max_hp = 1,
		pos_x = 0,
		pos_y = 0
	},
	items = [],
	persistence = [],
	quests = []
}

func save_game() -> void:
	update_player_data()
	update_scene_path()
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var json = JSON.stringify(current_save)
	file.store_line(json)
	game_saved.emit()
	
	
func load_game() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json := JSON.new()
	json.parse(file.get_line())
	current_save = json.get_data() as Dictionary
	
	LevelManager.load_new_level(current_save.scene_path, "", Vector2.ZERO)
	await LevelManager.level_load_started
	PlayerManager.set_player_position( Vector2(current_save.player.pos_x, current_save.player.pos_y))
	PlayerManager.set_player_hp(current_save.player.hp, current_save.player.max_hp)
	
	await LevelManager.level_loaded
	game_loaded.emit()
	
func update_player_data() -> void:
	var p : Player = PlayerManager.player
	current_save.player.hp = p.hp
	current_save.player.max_hp = p.max_hp
	current_save.player.pos_x = p.global_position.x
	current_save.player.pos_y = p.global_position.y
	
func update_scene_path() -> void:
	var scene : String = ""
	for c in get_tree().root.get_children():
		if c is Level:
			scene = c.scene_file_path
	current_save.scene_path = scene
