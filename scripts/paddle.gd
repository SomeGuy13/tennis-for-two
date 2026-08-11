extends Node2D

@export var down_input: String
@export var up_input: String
@export var paddle_speed: float = 150.0
var lower_bound: float = 515
var upper_bound: float = 125

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed(down_input):
		if position.y < lower_bound:
			position.y += paddle_speed * delta
	if Input.is_action_pressed(up_input):
		if position.y > upper_bound:
			position.y -= paddle_speed * delta
