extends Node2D

@export var anim_player : AnimationPlayer

func _ready() -> void:
	
	anim_player.play("victory")
	await anim_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
