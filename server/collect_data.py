import cv2
import mediapipe as mp
import pandas as pd
import os

mp_hands = mp.solutions.hands
hands = mp_hands.Hands(static_image_mode=False, max_num_hands=1, min_detection_confidence=0.5)
mp_draw = mp.solutions.drawing_utils

DATA_FILE = "data.csv"

def extract_landmarks(results):
    if not results.multi_hand_landmarks:
        return None
    landmarks = []
    for lm in results.multi_hand_landmarks[0].landmark:
        landmarks.extend([lm.x, lm.y, lm.z])
    return landmarks

# Create CSV if not exists
if not os.path.exists(DATA_FILE):
    pd.DataFrame(columns=[f"{c}{i}" for i in range(21) for c in ["x","y","z"]] + ["label"]).to_csv(DATA_FILE, index=False)

cap = cv2.VideoCapture(0)
label = input("Enter label for this session: ")

while True:
    ret, frame = cap.read()
    if not ret:
        break

    rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    results = hands.process(rgb)

    if results.multi_hand_landmarks:
        for hand_landmarks in results.multi_hand_landmarks:
            mp_draw.draw_landmarks(frame, hand_landmarks, mp_hands.HAND_CONNECTIONS)

    cv2.putText(frame, f"Label: {label}", (10,30), cv2.FONT_HERSHEY_SIMPLEX, 1, (0,255,0), 2)
    cv2.imshow("Collect Data - Press S to Save, Q to Quit", frame)

    key = cv2.waitKey(1) & 0xFF
    if key == ord("s"):
        landmarks = extract_landmarks(results)
        if landmarks:
            df = pd.read_csv(DATA_FILE)
            new_row = pd.DataFrame([landmarks + [label]], columns=df.columns)
            df = pd.concat([df, new_row], ignore_index=True)
            df.to_csv(DATA_FILE, index=False)
            print(f"Saved sample for {label}")
    elif key == ord("q"):
        break

cap.release()
cv2.destroyAllWindows()
