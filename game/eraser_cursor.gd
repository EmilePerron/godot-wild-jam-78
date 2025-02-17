extends Node2D

var hovered_obstacle = null

@onready var cursor_sprite_size = $Sprite2D.texture.get_width() * $Sprite2D.scale

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = get_global_mouse_position()


func _on_eraser_area_2d_area_entered(area: Area2D) -> void:
	if area.get_meta("is_obstacle_area2d", false):
		hovered_obstacle = _get_obstacle_from_area(area)


func _on_eraser_area_2d_area_exited(area: Area2D) -> void:
	if not hovered_obstacle or not area.get_meta("is_obstacle_area2d", false):
		return
		
	var obstacle = _get_obstacle_from_area(area)
	
	if obstacle == hovered_obstacle:
		hovered_obstacle = null


func _get_obstacle_from_area(area: Area2D) -> Node2D:
	var obstacle = area
	
	while not obstacle is Obstacle:
		if obstacle.name == "Obstacle":
			print(obstacle, obstacle is Obstacle)
		obstacle = obstacle.get_parent()
		
	return obstacle
	


func _on_eraser_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is not InputEventMouseButton or not event.is_pressed() or hovered_obstacle == null:
		return
		
	if not EraserCounter.can_erase():
		# TODO: Show some kind of error indicator
		return
	
	Eraser.erase(hovered_obstacle)
	EraserCounter.decrement()
	hovered_obstacle.queue_free()
	hovered_obstacle = null
