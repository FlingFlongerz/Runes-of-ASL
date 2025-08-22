import pandas as pd
import numpy as np
import torch
import torch.nn as nn
import torch.optim as optim
from sklearn.preprocessing import LabelEncoder
import joblib
from collections import Counter

# ============================
# 1. Load dataset
# ============================
DATA_FILE = "data.csv"
data = pd.read_csv(DATA_FILE)

X = data.drop("label", axis=1).values.astype(np.float32)
y = data["label"].values

# Encode labels
label_encoder = LabelEncoder()
y_encoded = label_encoder.fit_transform(y)

num_classes = len(label_encoder.classes_)
input_size = X.shape[1]

print("Classes trained on:", label_encoder.classes_)

# ============================
# 2. Class Weights for imbalance
# ============================
class_counts = Counter(y_encoded)
weights = [1.0 / class_counts[c] for c in y_encoded]  # inverse frequency
weights_tensor = torch.tensor(weights, dtype=torch.float32)

# Dataset & DataLoader
dataset = torch.utils.data.TensorDataset(
    torch.tensor(X), torch.tensor(y_encoded, dtype=torch.long)
)
sampler = torch.utils.data.WeightedRandomSampler(weights, len(weights))
dataloader = torch.utils.data.DataLoader(dataset, batch_size=32, sampler=sampler)

# ============================
# 3. Model
# ============================
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

model = ASLModel(input_size, num_classes)
criterion = nn.CrossEntropyLoss()
optimizer = optim.Adam(model.parameters(), lr=0.001)

# ============================
# 4. Training Loop
# ============================
epochs = 30
for epoch in range(epochs):
    total_loss = 0
    correct, total = 0, 0

    for inputs, labels in dataloader:
        optimizer.zero_grad()
        outputs = model(inputs)
        loss = criterion(outputs, labels)
        loss.backward()
        optimizer.step()

        total_loss += loss.item()
        _, predicted = torch.max(outputs, 1)
        correct += (predicted == labels).sum().item()
        total += labels.size(0)

    acc = correct / total
    print(f"Epoch [{epoch+1}/{epochs}], Loss: {total_loss:.4f}, Train Acc: {acc:.2f}")

# ============================
# 5. Save model + encoder
# ============================
torch.save(model.state_dict(), "asl_model.pth")
joblib.dump(label_encoder, "label_encoder.pkl")
print("✅ Model and label encoder saved fresh")
