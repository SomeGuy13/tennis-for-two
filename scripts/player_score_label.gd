extends Label

@export var assigned_player: String
var score: int = 0

func _ready() -> void:
	EventBus.point_scored.connect(_handle_score)

func _handle_score(player: String):
	if player == assigned_player:
		score += 1
		text = str(score)
