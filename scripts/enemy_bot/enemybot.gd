extends Node


var fire_elements = ["flame on", "fire exit", "inheat assault"]
var water_elements = ["eda", "slimy substance", "wet and wild"]
var earth_elements = ["mountain dew", "bato dela rosa", "rock hard"]
var air_elements = ["blow", "careless whisper", "every breath you take"]
var nature_elements = ["outdoor", "touch grass", "morning wood"]
var dark_elements = ["lights off", "black jack", "dark hole"]
var lightning_elements = ["electrolytes", "voltes five", "electric fan"]
var light_elements = ["flashback", "lights on", "light of glory"]


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

func enemy_attack() -> Dictionary:
	var element_keys = element_spells.keys()
	var random_element = element_keys[randi() % element_keys.size()] 
	var spell_list = element_spells[random_element]
	var chosen_spell = spell_list[randi() % spell_list.size()] 
	var damage = chosen_spell.length() 
	
	return {
		"element": random_element,
		"spell": chosen_spell,
		"damage": damage
	}
