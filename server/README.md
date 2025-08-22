To run

python collect_data.py -> record hand signs press s to save each frame and q to close
python train.py -> delete first the asl_model.pth and label_encoder.pkl then the the train.py to save new model
python check_dataset.py  -> checks current labels that exists in the dataset
python predict.py -> test what label matches with current sign (main file to be connected in godot)