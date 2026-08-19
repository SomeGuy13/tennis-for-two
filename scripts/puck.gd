extends Node2D

@export var puck_velocity: Vector2 = Vector2(-300, 0)
@export var half_paddle_height: float = 0.75
@export var puck_bounce_speed = 1

var starting_position: Vector2
var starting_velocity: Vector2

func _ready() -> void:
	starting_position = position
	starting_velocity = puck_velocity

func _process(delta: float) -> void:
	position += puck_velocity * delta
	
	if position.x <= 50:
		EventBus.point_scored.emit("player 2")
		reset_puck(1)
	if position.x >= 1100:
		EventBus.point_scored.emit("player 1")
		reset_puck(-1)

func _on_body_entered(area: Area2D) -> void:
	if area.is_in_group("wall"):
		puck_velocity.y = puck_velocity.y * -1
	elif area.is_in_group("paddle"):
		if position.x >= 550:
			puck_velocity.x = -abs(puck_velocity.x)
		else:
			puck_velocity.x = abs(puck_velocity.x)
		
		var paddle_center = area.get_parent().position
		var hit_pos = (position.y - paddle_center.y) / (half_paddle_height)
		hit_pos = clamp(hit_pos, -1.0, 1.0)
		
		puck_velocity.y = hit_pos * -100
		print(puck_velocity.y, position.y, paddle_center.y, half_paddle_height)

func reset_puck(puck_direction: int) -> void:
	position = starting_position
	puck_velocity = starting_velocity * puck_direction
