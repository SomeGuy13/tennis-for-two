extends Control

func _one_player_play_button_down() -> void:
	# Actuall two player
	GameManager.set_game_state(GameManager.GameState.PLAYING)
	SceneManager.load_scene("res://scenes/two_player.tscn")

func _on_quit_button_down() -> void:
	get_tree().quit()

func _on_settings_button_down() -> void:
	SceneManager.load_scene("res://scenes/settings_menu.tscn")

func _two_player_play_button_down() -> void:
	# Actually one player
	GameManager.set_game_state(GameManager.GameState.PLAYING)
	SceneManager.load_scene("res://scenes/one_player.tscn")
