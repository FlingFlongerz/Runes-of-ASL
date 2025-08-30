extends Control

@export var bot_button : Button
@export var player_button : Button

var lobby_buttons : Array

func _ready() -> void:
	lobby_buttons = [
		bot_button,
		player_button
	]

func _process(delta: float) -> void:
	Animationscript.update_control_scale(lobby_buttons)

func _on_bot_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world/battlescreen.tscn")

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
