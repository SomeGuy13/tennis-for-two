extends Node2D

@export var down_input: String
@export var up_input: String
@export var paddle_speed: float = 150.0
@export var automatic: bool = false
@onready var puck: Node2D = $"../Puck"
@export var paddle_side_mult: int = 1
var lower_bound: float = 515
var upper_bound: float = 125

func _physics_process(delta: float) -> void:
	if !automatic:
		if Input.is_action_pressed(down_input):
			if position.y < lower_bound:
				position.y += paddle_speed * delta
		if Input.is_action_pressed(up_input):
			if position.y > upper_bound:
				position.y -= paddle_speed * delta
	elif automatic and puck.puck_velocity.x * paddle_side_mult * -1 < 0:
		if position.y < puck.position.y and position.y < lower_bound:
			position.y += paddle_speed * delta
		if position.y > puck.position.y and position.y > upper_bound:
			position.y -= paddle_speed * delta
