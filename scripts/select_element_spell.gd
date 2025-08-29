extends Control

@onready var button1 = $Spell1
@onready var button2 = $Spell2
@onready var button3 = $Spell3


@onready var elements_button = {
	"Fire": preload("res://assets/buttons/button_themes/fire_element_theme.tres"),
	"Water": preload("res://assets/buttons/button_themes/water_element_theme.tres"),
	"Earth": preload("res://assets/buttons/button_themes/earth_element_theme.tres"),
	"Air": preload("res://assets/buttons/button_themes/air_element_theme.tres"),
	"Nature": preload("res://assets/buttons/button_themes/nature_element_theme.tres"),
	"Dark": preload("res://assets/buttons/button_themes/dark_element_theme.tres"),
	"Light": preload("res://assets/buttons/button_themes/light_element_theme.tres"),
	"Lightning": preload("res://assets/buttons/button_themes/lightning_element_theme.tres")
}




var fire_elements = ["flame on", "fire exit", "inheat assault"]
var water_elements = ["eda", "slimy substance", "wet and wild"]
var earth_elements = ["mountain dew", "bato dela rosa", "rock hard"]
var air_elements = ["blow", "careless whisper", "every breath you take"]
var nature_elements = ["outdoor", "touch grass", "morning wood"]
var dark_elements = ["lights off", "black jack", "dark hole"]
var lightning_elements = ["electrolytes", "voltes five", "electric fan"]
var light_elements = ["flashback", "lights on", "light of glory"]

# Map elements to their spells
var element_spells = {
	"Fire": fire_elements,
	"Water": water_elements,
	"Earth": earth_elements,
	"Air": air_elements,
	"Nature": nature_elements,
	"Dark": dark_elements,
	"Light": light_elements,
	"Lightning": lightning_elements
}

func _ready() -> void:
	if Global.element_selected in element_spells:
		var spells = element_spells[Global.element_selected]

		# Assign theme instead of icon
		if Global.element_selected in elements_button:
			var theme = elements_button[Global.element_selected]
			button1.theme = theme
			button2.theme = theme
			button3.theme = theme

		# Set spell names as text
		button1.text = spells[0]
		button2.text = spells[1]
		button3.text = spells[2]

func _process(delta: float) -> void:
	Animationscript.update_control_scale(button1)
	Animationscript.update_control_scale(button2)
	Animationscript.update_control_scale(button3)

func _on_button_pressed() -> void:
	Global.spell_selected = button1.text
	print(Global.spell_selected)
	get_tree().change_scene_to_file("res://scenes/finger_spell_screen.tscn")
	
	
func _on_button_2_pressed() -> void:
	Global.spell_selected = button2.text
	print(Global.spell_selected)
	get_tree().change_scene_to_file("res://scenes/finger_spell_screen.tscn")

func _on_button_3_pressed() -> void:
	Global.spell_selected = button3.text
	print(Global.spell_selected)
	get_tree().change_scene_to_file("res://scenes/finger_spell_screen.tscn")


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/battlescreen.tscn")
