extends CharacterBody2D


const SPEED := 1000.0
const FALL_SPEED_MULTIPLIER := 3.0
const JUMP_VELOCITY := -1000.0


func _physics_process(delta: float) -> void:
	velocity.x = 0
	
	if not is_on_floor(): 
		var is_falling = velocity.y > 0
		
		# Allow player to hold for longer jumps... 
		# or early release for small jump
		if not is_falling and not Input.is_action_pressed("ui_accept"):
			velocity.y = 0   
		
		velocity.y += (get_gravity() * delta * FALL_SPEED_MULTIPLIER).y
		
		# Make falling a bit faster than jumping
		if is_falling:
			velocity.y *= 1 + (delta)

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	move_and_slide()
