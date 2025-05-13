extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 180.0
const ACCELERATION = 15.0

enum direction {RIGHT, LEFT, DOWN, UP}

var input: Vector2
var is_walking: bool = false
var current_direction: direction = direction.RIGHT

func get_input():
	input.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return input.normalized()

func get_direction(x, y):
	if(x < 0):
		is_walking = true
		current_direction = direction.LEFT
	elif(x > 0):
		is_walking = true
		current_direction = direction.RIGHT
	elif(y > 0):
		is_walking = true
		current_direction = direction.DOWN
	elif(y < 0):
		is_walking = true
		current_direction = direction.UP
	else:
		is_walking = false

func play_animation():
	if(is_walking):
		match current_direction:
			direction.RIGHT:
				animated_sprite_2d.play("walk_right")
			direction.LEFT:
				animated_sprite_2d.play("walk_left")
			direction.DOWN:
				animated_sprite_2d.play("walk_front")
			direction.UP:
				animated_sprite_2d.play("walk_back")
	else:
		match current_direction:
			direction.RIGHT:
				animated_sprite_2d.play("idle_right")
			direction.LEFT:
				animated_sprite_2d.play("idle_left")
			direction.DOWN:
				animated_sprite_2d.play("idle_front")
			direction.UP:
				animated_sprite_2d.play("idle_back")

func _ready():
	pass

func _process(delta):
	var playerInput = get_input()
	velocity = lerp(velocity, playerInput * SPEED, delta * ACCELERATION)
	get_direction(playerInput.x, playerInput.y)
	play_animation()
	move_and_slide()
