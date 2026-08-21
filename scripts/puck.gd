extends Node2D

@export var puck_velocity: Vector2 = Vector2(-300, 0)
@export var half_paddle_height: float = 0.75
@export var puck_bounce_speed = 1
@export var puck_increment_speed = 10

@onready var polygon: Polygon2D = $Polygon2D
@onready var particle: CPUParticles2D = $CPUParticles2D

var starting_position: Vector2
var starting_velocity: Vector2

func _ready() -> void:
	starting_position = position
	starting_velocity = puck_velocity
	
	EventBus.point_scored.connect(reset_puck)

func _process(delta: float) -> void:
	position += puck_velocity * delta
	
	if position.x <= 50 :
		EventBus.point_scored.emit("player 2")
	if position.x >= 1100:
		EventBus.point_scored.emit("player 1")

func _on_body_entered(area: Area2D) -> void:
	if area.is_in_group("wall"):
		puck_velocity.y = puck_velocity.y * -1
	elif area.is_in_group("paddle"):
		if position.x >= 550:
			puck_velocity.x = -abs(puck_velocity.x + puck_increment_speed)
			print(puck_velocity)
		else:
			puck_velocity.x = abs(puck_velocity.x - puck_increment_speed)
			print(puck_velocity)
		
		var paddle_center = area.get_parent().position
		var hit_pos = (position.y - paddle_center.y) / (half_paddle_height)
		hit_pos = clamp(hit_pos, -1.0, 1.0)
		
		puck_velocity.y = hit_pos * -100

func reset_puck(player: String) -> void:
	particle.emitting = true
	position = starting_position
	puck_velocity = Vector2.ZERO
	polygon.visible = false
	
	await particle.finished
	
	match player:
		"player 1":
			puck_velocity = -starting_velocity
		"player 2":
			puck_velocity = starting_velocity
		_:
			pass
	polygon.visible = true
