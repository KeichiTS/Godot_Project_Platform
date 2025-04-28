extends CharacterBody2D

# Constant
const SPEED: float = 80.0
const JUMP_VELOCITY: float = -200.0

#Variables
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

## Callback Functions
func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	jump()
	move_horizontally()

## Move Functions
func apply_gravity(delta) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

func jump() -> void:
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

func move_horizontally() -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		change_sprite_face_direction(velocity.y)
	else: 
		velocity.x = move_toward(velocity.x, 0, SPEED)
	chance_animation_to_idle_or_run(direction)
	move_and_slide()

## Sprite Animation Functions
func change_sprite_face_direction(face_side) -> void:
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

func chance_animation_to_idle_or_run(isMoving)-> void:
	if isMoving != 0:
		$AnimatedSprite2D.play("Run")
	else:
		$AnimatedSprite2D.play("Idle")
