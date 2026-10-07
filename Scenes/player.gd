extends CharacterBody2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = $"."


const SPEED = 160.0
const JUMP_VELOCITY = -300.0

var health : int
var damage : int

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if velocity.x > 0:
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("Run")
		
	if velocity.x < 0:
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.play("Run")
		
	if velocity.x == 0:
		animated_sprite_2d.play("idle")
	if velocity.y > 0:
		animated_sprite_2d.play("Jump")
	move_and_slide()   # <-- must be here, at the same indent as the `if` statements
