extends Control

# A container to hold the letter buttons
@onready var container = $HBoxContainer  # or HBoxContainer / GridContainer depending on layout
@onready var cast_button = $cast_button
var ready_to_cast = false

func _ready() -> void:
	# Get the selected spell from Global
	var spell = Global.spell_selected
	print("Loaded spell:", spell)

	# Remove spaces, then split into characters
	var letters = spell.replace(" ", "").split("")

	# Create a button for each letter
	for letter in letters:
		var btn = Button.new()
		btn.text = letter
		btn.custom_minimum_size = Vector2(60, 60)  # optional: size of each letter button
		btn.connect("pressed", Callable(self, "_on_letter_pressed").bind(letter))
		container.add_child(btn)


func _on_letter_pressed(letter: String) -> void:
	print("Pressed letter:", letter)
	
func _process(delta: float) -> void:
	if ready_to_cast == true:
		cast_button.disabled = false
		
	



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/select_element_spell.tscn")


func _on_cast_button_pressed() -> void:
	Global.enemy_health_points = Global.enemy_health_points - 10
	get_tree().change_scene_to_file("res://scenes/battlescreen.tscn")
