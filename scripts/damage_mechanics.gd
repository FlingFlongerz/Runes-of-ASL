extends Node

var playerspellstats = {
	"element": "",
	"spell": "",
	"damage": 0
}

var enemyspellstats = {
	"element": "",
	"spell": "",
	"damage": 0
}

# Elemental advantage rules
var element_chart = {
	"Fire": ["Nature", "Air"],       # Fire beats Nature, Air
	"Water": ["Fire", "Lightning"],  # Water beats Fire, Lightning
	"Earth": ["Lightning", "Light"], # Earth beats Lightning, Light
	"Air": ["Earth", "Dark"],        # Air beats Earth, Dark
	"Nature": ["Water", "Light"],    # Nature beats Water, Light
	"Dark": ["Light", "Nature"],     # Dark beats Light, Nature
	"Light": ["Dark", "Fire"],       # Light beats Dark, Fire
	"Lightning": ["Air", "Water"]    # Lightning beats Air, Water
}

func compare_elements(player: Dictionary, enemy: Dictionary):
	var p_elem = player["element"]
	var e_elem = enemy["element"]

	# Same element → resistance
	if p_elem == e_elem:
		player["damage"] = int(player["damage"] / 2)
		enemy["damage"] = int(enemy["damage"] / 2)
		print("🛡 Both used %s → damage halved for both!" % p_elem)
		Global.player_health_points -= enemy["damage"]
		Global.enemy_health_points -= player["damage"]

	# Player advantage
	elif element_chart.has(p_elem) and e_elem in element_chart[p_elem]:
		player["damage"] *= 2
		enemy["damage"] = int(enemy["damage"] / 2)
		print("✅ Player's %s beats Enemy's %s! Player dmg x2, Enemy dmg /2" % [p_elem, e_elem])
		Global.player_health_points -= enemy["damage"]
		Global.enemy_health_points -= player["damage"]

	# Enemy advantage
	elif element_chart.has(e_elem) and p_elem in element_chart[e_elem]:
		enemy["damage"] *= 2
		player["damage"] = int(player["damage"] / 2)
		print("❌ Enemy's %s beats Player's %s! Enemy dmg x2, Player dmg /2" % [e_elem, p_elem])
		Global.player_health_points -= enemy["damage"]
		Global.enemy_health_points -= player["damage"]

	# Neutral
	else:
		print("⚖️ Player's %s and Enemy's %s are neutral. Damage unchanged." % [p_elem, e_elem])
		Global.player_health_points -= enemy["damage"]
		Global.enemy_health_points -= player["damage"]
