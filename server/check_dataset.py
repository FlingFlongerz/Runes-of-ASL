import pandas as pd

df = pd.read_csv("data.csv")
labels = df.iloc[:, -1].astype(str).str.strip().str.upper()
print("Unique labels:", sorted(labels.unique()))
print("\nCounts:\n", labels.value_counts())
