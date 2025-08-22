extends Control

# A container to hold the letter buttons
@onready var container = $HBoxContainer  # or HBoxContainer / GridContainer depending on layout

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
