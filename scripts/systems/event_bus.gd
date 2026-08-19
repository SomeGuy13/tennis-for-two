extends Node

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

# InputSystem Signals
signal input_action_pressed(action: String)
signal input_action_released(action: String)

# Game Signals
signal point_scored(player: String)
signal game_paused(state: bool)

signal game_state_changed(state: GameManager.GameState)
