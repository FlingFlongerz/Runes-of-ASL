extends Node2D

var player_hp = GameManager.player_health_points
var enemy_hp = GameManager.enemy_health_points
@onready var player_hp_bar = $Player_hp
@onready var enemy_hp_bar = $Enemy_hp


var ready_to_cast = true
@onready var start_cast = $Player_select_element
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if ready_to_cast == true:
		start_cast.show()
		ready_to_cast = false
	
	player_hp_bar.value = player_hp
	enemy_hp_bar.value = enemy_hp
	
	if enemy_hp <= 0:
		get_tree().change_scene_to_file("res://scenes/cutscenes/victory_cutscene.tscn")

func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
