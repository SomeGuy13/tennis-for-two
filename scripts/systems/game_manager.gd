extends Node

var _dependencies = ["EventBus", "InputSystem"]
enum GameState { MENU, LOADING, PLAYING, PAUSED, GAME_OVER, CUTSCENE }

var _current_state: GameState = GameState.MENU

func _check_dependencies():
	for dependance in _dependencies:
		if get_node_or_null("/root/%s" % dependance) == null:
			push_error("Autoload %s does not exist" % dependance)

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	_check_dependencies()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func set_game_state(new_state: GameState) -> void:
	if new_state == _current_state:
		return
	
	_current_state = new_state
	
	match new_state:
		GameState.MENU:
			print("Game State: Menu")
		GameState.LOADING:
			print("Game State: Loading")
		GameState.PAUSED:
			get_tree().paused = true
			#InputSystem.set_enabled(true)
			print("Game State: Paused")
		GameState.PLAYING:
			get_tree().paused = false
			InputSystem.set_enabled(true)
			print("Game State: Playing")
		GameState.CUTSCENE:
			InputSystem.set_enabled(false)
			print("Game State: Cutscene")
		GameState.GAME_OVER:
			print("Game State: Game Over")
		_:
			pass
	
	EventBus.game_state_changed.emit(new_state)

func get_current_game_state() -> GameState:
	return _current_state
