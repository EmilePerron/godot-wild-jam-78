extends Node2D

const BASE_SPEED := 250

@export var speed_multiplier := 1.0
@export var victory_area: Area2D

@onready var game_manager = get_parent()


func _ready() -> void:
	victory_area.body_entered.connect(Callable(self, "_on_victory"))


func _physics_process(delta: float) -> void:
	position.x -= BASE_SPEED * speed_multiplier * delta


func _on_victory(body: Node2D) -> void:
	if body.name != "Player":
		return
		
	# Level completed!
	speed_multiplier = 0.0
	GameManager.instance.level_completed.emit()
	
