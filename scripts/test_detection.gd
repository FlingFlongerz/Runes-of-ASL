extends Node

var client := StreamPeerTCP.new()
var received_messages := {}

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
			if not received_messages.has(text):
				print("📩 Received:", text)
				received_messages.clear()
				received_messages.get_or_add(text)
