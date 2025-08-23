extends Node

var client : StreamPeerTCP
var connected = false

# -------------------------
# Change these if needed
# -------------------------
const HOST = "127.0.0.1"
const PORT = 8765

func _ready():
	client = StreamPeerTCP.new()
	var err = client.connect_to_host(HOST, PORT)
	if err == OK:
		connected = true
		print("✅ Connected to Python ASL TCP server")
	else:
		print("❌ Could not connect:", err)

func _process(_delta):
	if connected:
		var available_bytes = client.get_available_bytes()
		if available_bytes > 0:
			var msg = client.get_utf8_string(available_bytes)
			# Split messages by newline (in case Python sends multiple JSON objects)
			for line in msg.strip_edges().split("\n"):
				if line == "":
					continue
				var parse_result = JSON.parse_string(line)
				if parse_result.error == OK:
					var data = parse_result.result
					if typeof(data) == TYPE_DICTIONARY and data.has("top_prediction"):
						print("Top prediction:", data["top_prediction"])
				else:
					print("⚠ JSON parse error:", parse_result.error_string)
