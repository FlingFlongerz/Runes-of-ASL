extends Node

# letter detected from the cam
var detected_letter: String = ""

# type of element selected
var element_selected: String = ""

# what element selected
var spell_selected: String = ""

# is the player ready to cast
var ready_to_cast: bool = false

# timer for casting 
var overall_cast_time: int = 60

# player hp
var player_health_points: int = 100

# enemy hp
var enemy_health_points: int = 100

#------------------------------------------
var client := StreamPeerTCP.new()
var last_detected_letter: String = ""


func _ready():
	print("🚀 Trying to connect...")
	client.connect_to_host("127.0.0.1", 8765)

	# Blocking-style loop
	var attempts := 0
	while client.get_status() == StreamPeerTCP.STATUS_CONNECTING and attempts < 50:
		client.poll()
		attempts += 1
		await get_tree().create_timer(0.1).timeout

	if client.get_status() == StreamPeerTCP.STATUS_CONNECTED:
		print("✅ Connected!")
	else:
		print("❌ Failed to connect, status =", client.get_status())


func _process(_delta):
	if client.get_status() == StreamPeerTCP.STATUS_CONNECTED:
		var available := client.get_available_bytes()
		if available > 0:
			var text := client.get_utf8_string(available)

			# Try parsing as JSON
			var parsed = JSON.parse_string(text)
			if parsed and parsed.has("top_prediction"):
				detected_letter = str(parsed["top_prediction"]).to_upper()
			
			else:
				detected_letter = text.strip_edges().to_upper()
			
			# Only log + update if it's a new unique letter
			if detected_letter != last_detected_letter:
				print("📩 New detected letter:", detected_letter)
				last_detected_letter = detected_letter
