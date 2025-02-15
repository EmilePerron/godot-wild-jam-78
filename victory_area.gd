extends Area2D

@onready var victory_area_sprite := $Sprite2D
@onready var victory_collision_shape := $CollisionShape2D


func _ready() -> void:
	victory_area_sprite.position = victory_collision_shape.position 
	victory_area_sprite.region_rect = victory_collision_shape.shape.get_rect()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
