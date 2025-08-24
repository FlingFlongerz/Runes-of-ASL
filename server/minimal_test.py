import socket, time, json

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server.bind(("127.0.0.1", 8765))
server.listen(1)
print("✅ TCP server waiting for Godot...")

conn, addr = server.accept()
print(f"✅ Godot connected from {addr}")

try:
    while True:
        msg = json.dumps({"top_prediction": "TEST"})
        conn.sendall(msg.encode("utf-8") + b"\n")
        print("➡️ Sent:", msg)
        time.sleep(1)
except:
    conn.close()
    server.close()
