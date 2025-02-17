extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

const MAX_JUMP = 2
var jump = 0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	jump_handler()
			
	var direction := Input.get_axis("move_left", "move_right")
	
	animation_handler(direction)
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func jump_handler() -> void:
	if is_on_floor():
		jump = 0
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump += 1
		
	if Input.is_action_just_pressed("jump") and not is_on_floor() and jump < MAX_JUMP:
		velocity.y = JUMP_VELOCITY
		jump += 1

func animation_handler(direction: float) -> void:
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
