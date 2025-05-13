extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D/CollisionShape2D

enum state {OPEN, CLOSE}
var current_state: state = state.CLOSE

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	interaction_area.body_exited.connect(_on_body_exit)
	animated_sprite_2d.animation_finished.connect(_on_animation_finished)

func _on_interact():
	if(current_state == state.CLOSE):
		animated_sprite_2d.play("open")
		current_state = state.OPEN	

func _on_animation_finished():
	if(current_state == state.OPEN):
		collision_shape_2d.call_deferred("set_disabled", true)

func _on_body_exit(body):
	if(current_state == state.OPEN):
		animated_sprite_2d.play("close")
		current_state = state.CLOSE
		collision_shape_2d.call_deferred("set_disabled", false)
