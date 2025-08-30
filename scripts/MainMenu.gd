extends Control


@export var play_button : Button
@export var credits_button : Button
@export var quit_button : Button
@export var main_title : Label
@export var team_name : Label

var main_menu_buttons : Array

func _ready() -> void:
	main_title = $Title
	main_menu_buttons = [
		play_button,
		credits_button,
		quit_button
	]

func _process(delta: float) -> void:
	Animationscript.update_label_scale(main_title)
	Animationscript.update_label_scale(team_name)
	Animationscript.update_control_scale(main_menu_buttons)

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/lobby.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
