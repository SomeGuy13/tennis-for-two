extends Control

func _on_back_button_button_down() -> void:
	SceneManager.load_scene("res://scenes/main_menu.tscn")
