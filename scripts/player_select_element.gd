extends Control


@export var player_spell_activated = false
@export var player_selected = false


				
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

func _on_wind_pressed() -> void:
	Global.element_selected = "Wind"
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
	
	
