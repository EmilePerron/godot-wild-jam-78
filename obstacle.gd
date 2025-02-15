extends Node2D
class_name Obstacle


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return
		
	get_tree().quit()
		
