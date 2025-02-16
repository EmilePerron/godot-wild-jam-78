extends Node2D
class_name GameManager

signal level_completed
signal player_died(message: String)

static var instance: GameManager

var _game_is_active := true

@export var win_overlay: Control

@onready var _current_level = $Level
@onready var _current_level_label = $UI/LevelLabel


func _ready() -> void:
	instance = self
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	level_completed.connect(Callable(self, "_on_level_completed"))
	player_died.connect(Callable(self, "_on_player_died"))


func _on_level_completed() -> void:
	win_overlay.visible = true
	_game_is_active = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	

func _on_player_died(message: String) -> void:
	get_tree().quit()
	

func _notification(notification):
	match notification:
		NOTIFICATION_WM_MOUSE_EXIT:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		NOTIFICATION_WM_MOUSE_ENTER:
			if _game_is_active:
				Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _show_loader() -> void:
	pass


func load_next_level() -> void:
	load_level(_current_level.level_number + 1)
	

func load_level(level: int) -> void:
	_show_loader()
	
	var padded_level = ("0" if level < 10 else "") + str(level)
	var new_level_path = "res://levels/level_" + padded_level + ".tscn"
	
	# When there's no more levels, show a YOU WIN! screen
	if not ResourceLoader.exists(new_level_path, "PackedScene"):
		return 
	
	var new_level_scene = load(new_level_path)
	var previous_level = _current_level
	_current_level = new_level_scene.instantiate()
	previous_level.add_sibling(_current_level)
	previous_level.queue_free()
	
	_current_level_label.text = "Level " + str(level)
	EraserCounter.refill()
	
	win_overlay.visible = false
	_game_is_active = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = false
