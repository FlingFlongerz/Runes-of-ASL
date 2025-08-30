extends Control

@onready var container = $CenterContainer/VBoxContainer
@onready var sprites_dict = {
	"res://assets/sprites/finger_spell_button11.png": "res://assets/sprites/finger_spell_button12.png",
	"res://assets/sprites/finger_spell_button21.png": "res://assets/sprites/finger_spell_button22.png",
	"res://assets/sprites/finger_spell_button31.png": "res://assets/sprites/finger_spell_button32.png",
}
@onready var cast_butt = $cast_button

var spell_buttons: Array[Button] = []
var current_index: int = 0
const BTN_SIZE := 220

func _ready() -> void:
	current_index = 0 # reset pointer every time scene loads
	spell_buttons.clear()
	cast_butt.disabled = false

	var spell: String = GameManager.player_spell_selected
	print("Loaded spell:", spell)

	var sprite_keys = sprites_dict.keys()

	# Start first line
	var line = HBoxContainer.new()
	line.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	line.alignment = BoxContainer.ALIGNMENT_CENTER
	container.add_child(line)

	for i in range(spell.length()):
		var char: String = spell.substr(i, 1)

		# Space → new line
		if char == " ":
			line = HBoxContainer.new()
			line.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			line.alignment = BoxContainer.ALIGNMENT_CENTER
			container.add_child(line)
			continue

		# Pick random textures
		var normal_path: String = sprite_keys[randi() % sprite_keys.size()]
		var pressed_path: String = sprites_dict[normal_path]

		# Make button
		var btn := Button.new()
		btn.toggle_mode = true
		btn.text = char
		btn.custom_minimum_size = Vector2(BTN_SIZE, BTN_SIZE)
		btn.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		btn.size_flags_vertical = Control.SIZE_SHRINK_CENTER

		# Styleboxes
		var normal_style := StyleBoxTexture.new()
		normal_style.texture = load(normal_path)
		btn.add_theme_stylebox_override("normal", normal_style)

		var pressed_style := StyleBoxTexture.new()
		pressed_style.texture = load(pressed_path)
		btn.add_theme_stylebox_override("pressed", pressed_style)

		# Hover & focus should look like normal
		btn.add_theme_stylebox_override("hover", normal_style)
		btn.add_theme_stylebox_override("focus", normal_style)

		# Font scaling
		var font_size := int(BTN_SIZE * 0.6)
		btn.add_theme_font_size_override("font_size", font_size)
		#btn.add_theme_font_override("font", load("res://assets/buttons/Anglorunic.otf"))

		# Text color
		btn.add_theme_color_override("font_color", Color.WHITE)

		# Connect
		btn.connect("toggled", Callable(self, "_on_letter_toggled").bind(char, btn))
		line.add_child(btn)
		spell_buttons.append(btn)


func _process(_delta: float) -> void:
	if spell_buttons.is_empty():
		return
	if current_index >= spell_buttons.size():
		return # All buttons already handled

	var current_btn: Button = spell_buttons[current_index]
	var current_letter: String = current_btn.text.to_upper() # normalize button text

	# Compare with already-normalized Global.detected_letter
	if Global.detected_letter == current_letter and not current_btn.button_pressed:
		print("✅ Matched:", current_letter)

		# Properly press the button (updates visuals)
		current_btn.set_pressed_no_signal(true)

		# Fire toggled signal manually so _on_letter_toggled runs
		current_btn.emit_signal("toggled", true)

		# Move to the next button
		current_index += 1

		# Check if all buttons are pressed → enable cast button
		if current_index >= spell_buttons.size():
			cast_butt.disabled = false
			print("✨ All buttons pressed! Cast is now enabled.")


func _on_letter_toggled(button_pressed: bool, letter: String, btn: Button) -> void:
	print("Toggled letter:", letter, " State:", button_pressed)
	if button_pressed:
		btn.add_theme_color_override("font_color", Color.GREEN)
	else:
		btn.add_theme_color_override("font_color", Color.WHITE)


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_scenes/select_element_spell.tscn")

func _on_cast_button_pressed() -> void:
	var enemyspellstats = Enemybot.enemy_attack()
	var playerspellstats = {
		"element" : GameManager.player_element_selected,
		"spell" : GameManager.player_spell_selected,
		"damage" : GameManager.player_spell_selected.replace(" ","").length()
	}
	print(enemyspellstats["damage"])
	DamageManager.compare_elements(playerspellstats, enemyspellstats)
	get_tree().change_scene_to_file("res://scenes/world/battlescreen.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_scenes/select_element_spell.tscn")
