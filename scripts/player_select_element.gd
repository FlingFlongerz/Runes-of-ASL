extends Control


@export var player_spell_activated = false
@export var player_selected = false
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
	Global.element_selected = "Fire"
	player_selected = true
	get_tree().change_scene_to_file("res://scenes/select_element_spell.tscn")

func _on_water_pressed() -> void:
	Global.element_selected = "Water"
	player_selected = true
	get_tree().change_scene_to_file("res://scenes/select_element_spell.tscn")

func _on_earth_pressed() -> void:
	Global.element_selected = "Earth"
	player_selected = true
	get_tree().change_scene_to_file("res://scenes/select_element_spell.tscn")

func _on_lightning_pressed() -> void:
	print(Global.element_selected)
	Global.element_selected = "Lightning"
	player_selected = true
	get_tree().change_scene_to_file("res://scenes/select_element_spell.tscn")

func _on_nature_pressed() -> void:
	Global.element_selected = "Nature"
	player_selected = true
	get_tree().change_scene_to_file("res://scenes/select_element_spell.tscn")
	
func _on_light_pressed() -> void:
	Global.element_selected = "Light"
	player_selected = true
	get_tree().change_scene_to_file("res://scenes/select_element_spell.tscn")

func _on_dark_pressed() -> void:
	Global.element_selected = "Dark"
	player_selected = true
	get_tree().change_scene_to_file("res://scenes/select_element_spell.tscn")
	
func _on_air_pressed() -> void:
	Global.element_selected = "Air"
	player_selected = true
	get_tree().change_scene_to_file("res://scenes/select_element_spell.tscn")
