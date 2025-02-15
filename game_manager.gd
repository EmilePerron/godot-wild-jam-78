extends Node2D
class_name GameManager

signal level_completed

static var instance: GameManager

var _game_is_active := true

@export var win_overlay: Control

@onready var _current_level = $Level


func _ready() -> void:
	instance = self
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	level_completed.connect(Callable(self, "_on_level_completed"))


func _on_level_completed() -> void:
	win_overlay.visible = true
	_game_is_active = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	

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
	var new_level_scene = load("res://levels/level_" + padded_level + ".tscn")
	
	var previous_level = _current_level
	_current_level = new_level_scene.instantiate()
	previous_level.add_sibling(_current_level)
	previous_level.queue_free()
	
	win_overlay.visible = false
	_game_is_active = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = false
