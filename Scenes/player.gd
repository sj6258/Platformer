extends CharacterBody2D
class_name Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = $"."


const SPEED = 200.0
const JUMP_VELOCITY = -300.0
const MAX_JUMPS = 2

var health : int
var damage : int
var jump_count

var can_double_jump = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jump_count = 0

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			jump_count = 1
		elif can_double_jump and jump_count < MAX_JUMPS:
			velocity.y = JUMP_VELOCITY
			jump_count += 1

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
