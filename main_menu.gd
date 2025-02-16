extends Node2D

var game_scene := preload("res://game/game_scene.tscn")

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(game_scene)
