import numpy as np
import pandas as pd
import tensorflow as tf 
import csv, os
import scipy as sp
from keras.optimizers import Adam
from sklearn.preprocessing import LabelEncoder
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split
from keras.models import Sequential
from keras.layers import Dense, Activation, Flatten, Convolution1D, Dropout
from keras.callbacks import ModelCheckpoint, Callback, TensorBoard, ReduceLROnPlateau, LearningRateScheduler
from keras.optimizers import SGD
from keras.utils import np_utils


from keras.models import load_model
from sklearn.preprocessing import StandardScaler
from sklearn.pipeline import Pipeline  
from sklearn.linear_model import LinearRegression 
import matplotlib.pyplot as plt

#os.environ["CUDA_VISIBLE_DEVICES"] = "0"
os.environ["TF_CPP_MIN_LOG_LEVEL"]='2'

# 加载训练好的模型
model = load_model('/home/xuewen/Python/models/Model_DV_AUT.h5')  # train_model

# 加载测试数据
#test = pd.read_csv('/home/xuewen/Python/input/GlobCNN_A2011_I00480001.csv')


input_path = '/home/xuewen/Python/input/12_GlobCNN/'
output_path = '/home/xuewen/Python/predict/Pre_GlobCNN_DVAUT/'

path_list = os.listdir(input_path);
path_list.sort();
#print(path_list)

if not os.path.exists(output_path):
        os.makedirs(output_path)

for file in path_list:
	int_fname = os.path.join(input_path,file);
	print(int_fname);

	# 加载测试数据
	test = pd.read_csv(int_fname);

	test.rename(columns={'0':'season'},inplace = True)


	# 用于拟合的测试集观测值
	true = test.season
	Obs = np.vstack((true))


	def encode(test):
	    
	    test = test.drop('season', axis=1)

	    return test

	test = encode(test)



	X_test = np.array(test.values)


	#X_test = np.array(testx)
	nb_features = 365

	# reshape test data
	X_test_r = np.zeros((len(X_test), nb_features, 10))
	X_test_r[:, :, 0] = X_test[:, :nb_features]
	X_test_r[:, :, 1] = X_test[:, nb_features:730]
	X_test_r[:, :, 2] = X_test[:, 730:1095]
	X_test_r[:, :, 3] = X_test[:, 1095:1460]
	X_test_r[:, :, 4] = X_test[:, 1460:1825]
	X_test_r[:, :, 5] = X_test[:, 1825:2190]
	X_test_r[:, :, 6] = X_test[:, 2190:2555]
	X_test_r[:, :, 7] = X_test[:, 2555:2920]
	X_test_r[:, :, 8] = X_test[:, 2920:3285]
	X_test_r[:, :, 9] = X_test[:, 3285:]

	# 对测试数据进行预测
	preds = model.predict(X_test_r, batch_size = 1)
	print(preds)

	output = np.vstack((preds)) #在垂直方向上堆叠
	

	out_fname = os.path.join(output_path,file);
	print(out_fname);
	with open(out_fname, 'w', newline='')as f:
	 f_csv = csv.writer(f)
	 #f_csv.writerow(headers)
	 f_csv.writerows(output)

