import cv2
import mediapipe as mp
import torch
import torch.nn as nn
import joblib
import numpy as np
import os

print("Starting prediction...")

if not os.path.exists("asl_model.pth") or not os.path.exists("label_encoder.pkl"):
    print("❌ Missing trained model or label encoder. Run train.py first.")
    exit()

# Load label encoder & model
label_encoder = joblib.load("label_encoder.pkl")

class ASLModel(nn.Module):
    def __init__(self, input_size, num_classes):
        super(ASLModel, self).__init__()
        self.fc1 = nn.Linear(input_size, 128)
        self.fc2 = nn.Linear(128, 64)
        self.fc3 = nn.Linear(64, num_classes)
        self.relu = nn.ReLU()
    
    def forward(self, x):
        x = self.relu(self.fc1(x))
        x = self.relu(self.fc2(x))
        return self.fc3(x)

model = ASLModel(63, len(label_encoder.classes_))  # 21 landmarks * 3
model.load_state_dict(torch.load("asl_model.pth"))
model.eval()

mp_hands = mp.solutions.hands
hands = mp_hands.Hands(static_image_mode=False, max_num_hands=1, min_detection_confidence=0.5)
mp_draw = mp.solutions.drawing_utils

def extract_landmarks(results):
    if not results.multi_hand_landmarks:
        return None
    landmarks = []
    for lm in results.multi_hand_landmarks[0].landmark:
        landmarks.extend([lm.x, lm.y, lm.z])
    return np.array(landmarks, dtype=np.float32)

cap = cv2.VideoCapture(0)
if not cap.isOpened():
    print("❌ Could not access camera")
    exit()

print("✅ Camera opened. Press Q to quit.")

# ==========================
# Threshold
THRESHOLD = 0.5
# ==========================

last_probs = None
last_idxs = None
last_label = "Unknown"

while True:
    ret, frame = cap.read()
    if not ret:
        break

    rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    results = hands.process(rgb)

    landmarks = None
    if results.multi_hand_landmarks:
        for hand_landmarks in results.multi_hand_landmarks:
            mp_draw.draw_landmarks(frame, hand_landmarks, mp_hands.HAND_CONNECTIONS)
        landmarks = extract_landmarks(results)

    if landmarks is not None:
        with torch.no_grad():
            input_tensor = torch.tensor(landmarks, dtype=torch.float32).unsqueeze(0)
            outputs = model(input_tensor)

            probs = torch.softmax(outputs, dim=1)  # probabilities
            topk = len(label_encoder.classes_)     # show all possible classes
            top_probs, top_idxs = torch.topk(probs, topk)

            last_probs = top_probs.squeeze().cpu().numpy()
            last_idxs = top_idxs.squeeze().cpu().numpy()

            if last_probs[0] < THRESHOLD:
                last_label = "Unknown"
            else:
                last_label = label_encoder.inverse_transform([last_idxs[0]])[0]

    # Always show last known prediction
    cv2.putText(frame, f"Prediction: {last_label}", (10,60),
                cv2.FONT_HERSHEY_SIMPLEX, 1, (0,0,255), 2)

    if last_probs is not None and last_idxs is not None:
        for i in range(len(last_probs)):
            label = label_encoder.inverse_transform([last_idxs[i]])[0]
            conf = last_probs[i]
            cv2.putText(frame, f"{i+1}. {label}: {conf:.2f}",
                        (10, 100 + i*30),
                        cv2.FONT_HERSHEY_SIMPLEX, 0.8, (255,0,0), 2)

    cv2.imshow("ASL Prediction", frame)

    if cv2.waitKey(1) & 0xFF == ord("q"):
        break

cap.release()
cv2.destroyAllWindows()
