extends Control

func _ready() -> void:
	EventBus.game_paused.connect(_handle_game_pause)
	EventBus.input_action_pressed.connect(_handle_paused_action)

func _handle_game_pause(state: bool) -> void:
	print("called")
	if state == true:
		visible = true
		print("ran true")
		print(visible)
	if state == false:
		visible = false
		print("ran false")
		print(visible)

func _handle_paused_action(action: String):
	if action == "pause":
		if GameManager.get_current_game_state() == GameManager.GameState.PLAYING:
			EventBus.game_paused.emit(true)
			GameManager.set_game_state(GameManager.GameState.PAUSED)
		elif GameManager.get_current_game_state() == GameManager.GameState.PAUSED:
			EventBus.game_paused.emit(false)
			GameManager.set_game_state(GameManager.GameState.PLAYING)
		print("pressed")

func _on_continue_button_button_down() -> void:
	GameManager.set_game_state(GameManager.GameState.PLAYING)
	EventBus.game_paused.emit(false)

func _on_menu_button_button_down() -> void:
	GameManager.set_game_state(GameManager.GameState.MENU)
	SceneManager.load_scene("res://scenes/main_menu.tscn")
