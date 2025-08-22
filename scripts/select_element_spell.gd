extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
	
	
	
	
	
var list_of_elements = ["fire", "water", "air", "lightning", "wind", "earth", "nature", "light", "dark"]
var fire_elements = ["flame burst", "blazing dash", "ember strike" ]
var water_elements = ["wave push", "bubble shield", "aqua whip"]
var earth_elements = ["rock slam", "stone guard", "quake step"]
var air_elements = ["gust kick", "wind dash", "cyclone spin"]




func _on_button_pressed() -> void:
	print("spell 1")


func _on_button_2_pressed() -> void:
	print("spell 2")


func _on_button_3_pressed() -> void:
	print("spell 3")
