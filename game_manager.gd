extends Node2D
class_name GameManager

signal level_completed

static var instance: GameManager

var _game_is_active := true

@export var win_overlay: Control


func _ready() -> void:
	instance = self
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	level_completed.connect(Callable(self, "_on_level_completed"))


func _on_level_completed() -> void:
	win_overlay.visible = true
	_game_is_active = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	

func _notification(notification):
	match notification:
		NOTIFICATION_WM_MOUSE_EXIT:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		NOTIFICATION_WM_MOUSE_ENTER:
			if _game_is_active:
				Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
