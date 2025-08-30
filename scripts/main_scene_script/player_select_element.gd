extends Control

@export var fire_button : Button
@export var water_button : Button
@export var earth_button : Button
@export var air_button : Button
@export var lightning_button : Button
@export var nature_button : Button
@export var light_button : Button
@export var dark_button : Button

var elements_button: Array

func _ready() -> void:
	elements_button = [
		fire_button,
		water_button, 
		earth_button,
		air_button,
		lightning_button,
		nature_button,
		light_button,
		dark_button
		]
		
func _process(delta: float) -> void:
	Animationscript.update_control_scale(elements_button)


				
func _on_fire_pressed() -> void:
	GameManager.player_element_selected = "Fire"
	get_tree().change_scene_to_file("res://scenes/main_scenes/select_element_spell.tscn")

func _on_water_pressed() -> void:
	GameManager.player_element_selected = "Water"
	get_tree().change_scene_to_file("res://scenes/main_scenes/select_element_spell.tscn")

func _on_earth_pressed() -> void:
	GameManager.player_element_selected = "Earth"
	get_tree().change_scene_to_file("res://scenes/main_scenes/select_element_spell.tscn")

func _on_lightning_pressed() -> void:
	GameManager.player_element_selected = "Lightning"
	get_tree().change_scene_to_file("res://scenes/main_scenes/select_element_spell.tscn")

func _on_nature_pressed() -> void:
	GameManager.player_element_selected = "Nature"
	get_tree().change_scene_to_file("res://scenes/main_scenes/select_element_spell.tscn")
	
func _on_light_pressed() -> void:
	GameManager.player_element_selected = "Light"
	get_tree().change_scene_to_file("res://scenes/main_scenes/select_element_spell.tscn")

func _on_dark_pressed() -> void:
	GameManager.player_element_selected = "Dark"
	get_tree().change_scene_to_file("res://scenes/main_scenes/select_element_spell.tscn")
	
func _on_air_pressed() -> void:
	GameManager.player_element_selected = "Air"
	get_tree().change_scene_to_file("res://scenes/main_scenes/select_element_spell.tscn")
