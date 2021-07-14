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
from keras.layers import Dense, Activation, Flatten, Convolution1D, MaxPooling1D, AveragePooling1D, Dropout
from keras.callbacks import ModelCheckpoint, Callback, TensorBoard, ReduceLROnPlateau, LearningRateScheduler
from keras.optimizers import SGD
from keras.utils import np_utils

np.random.seed(1000)

from keras.models import load_model
from sklearn.preprocessing import StandardScaler
from sklearn.pipeline import Pipeline  
from sklearn.linear_model import LinearRegression 
import matplotlib.pyplot as plt


os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'


# 读取数据集（训练-验证，测试）

train = pd.read_csv('/home/xuewen/Python/input/SD_TrainWIN_A2008.csv')
test = pd.read_csv('/home/xuewen/Python/input/SD_TestsWIN_A2008.csv')

train.rename(columns={'0':'season'},inplace = True)  
test.rename(columns={'0':'season'},inplace = True)


# 用于拟合的测试集观测值
true = test.season
Obs = np.vstack((true))


def encode(train,test):
    label_encoder = LabelEncoder().fit(train.season)
    labels = train.season #label_encoder.transform(train.season)
    classes = list(label_encoder.classes_)

    train = train.drop('season', axis=1)
    test = test.drop('season', axis=1)

    return train, test, labels, classes

train, test, labels, classes = encode(train,test)


scaled_train = np.array(train.values)
  
# split train data into train and validation

X_train,X_valid, y_train, y_valid = train_test_split(scaled_train,labels,test_size=0.2, random_state=25)

nb_features = 365 # number of features per features type (14 variables)   



# reshape train data

X_train_r = np.zeros((len(X_train), nb_features, 14))
X_train_r[:, :, 0] = X_train[:, :nb_features]
X_train_r[:, :, 1] = X_train[:, nb_features:730]
X_train_r[:, :, 2] = X_train[:, 730:1095]
X_train_r[:, :, 3] = X_train[:, 1095:1460]
X_train_r[:, :, 4] = X_train[:, 1460:1825]
X_train_r[:, :, 5] = X_train[:, 1825:2190]
X_train_r[:, :, 6] = X_train[:, 2190:2555]
X_train_r[:, :, 7] = X_train[:, 2555:2920]
X_train_r[:, :, 8] = X_train[:, 2920:3285]
X_train_r[:, :, 9] = X_train[:, 3285:3650]
X_train_r[:, :, 10] = X_train[:, 3650:4015]
X_train_r[:, :, 11] = X_train[:, 4015:4380]
X_train_r[:, :, 12] = X_train[:, 4380:4745]
X_train_r[:, :, 13] = X_train[:, 4745:]

# reshape validation data

X_valid_r = np.zeros((len(X_valid), nb_features, 14))
X_valid_r[:, :, 1] = X_valid[:, nb_features:730]
X_valid_r[:, :, 2] = X_valid[:, 730:1095]
X_valid_r[:, :, 3] = X_valid[:, 1095:1460]
X_valid_r[:, :, 4] = X_valid[:, 1460:1825]
X_valid_r[:, :, 5] = X_valid[:, 1825:2190]
X_valid_r[:, :, 6] = X_valid[:, 2190:2555]
X_valid_r[:, :, 7] = X_valid[:, 2555:2920]
X_valid_r[:, :, 8] = X_valid[:, 2920:3285]
X_valid_r[:, :, 9] = X_valid[:, 3285:3650]
X_valid_r[:, :, 10] = X_valid[:, 3650:4015]
X_valid_r[:, :, 11] = X_valid[:, 4015:4380]
X_valid_r[:, :, 12] = X_valid[:, 4380:4745]
X_valid_r[:, :, 13] = X_valid[:, 4745:]

# Keras model with one Convolution1D layer

# build model

model = Sequential()
model.add(Convolution1D(nb_filter=512, filter_length=3, input_shape=(nb_features, 14)))
model.add(AveragePooling1D(2))
model.add(Convolution1D(nb_filter=512, filter_length=3, input_shape=(nb_features, 14)))
model.add(AveragePooling1D(2))
model.add(Convolution1D(nb_filter=512, filter_length=3, input_shape=(nb_features, 14)))
model.add(Activation('relu'))
#model.add(MaxPooling1D(2))
model.add(Flatten())    # this converts our 3D feature maps to 1D feature vectors
model.add(Dropout(0.4))
model.add(Dense(16, activation='relu'))  #256
model.add(Dense(1))


# 定义训练方式 train model  


#learning rate schedule

def lr_schedule(epoch):
    lr_base = 1e-3
    epochs=100
    lr_power = 0.45
    lr = lr_base * ((1 - float(epoch) / epochs) ** lr_power)
    print('learning rate:', lr)
    return float(lr)

# 回调函数

#opt = Adam(lr=1e-3, decay=1e-3 / 2)
callbacks_list = [
        ModelCheckpoint(
        filepath='/home/xuewen/Python/models/process/best_model.{epoch:02d}-{val_loss:.2f}.h5', 
        monitor='val_loss', verbose = 0, save_best_only=True, save_weights_only=False, mode ='min',period = 1),
        LearningRateScheduler(lr_schedule) 
]



model.compile(loss='mse',optimizer= 'adam' ,metrics=['mae']) 


print(model.summary())


# 开始训练
history = model.fit(X_train_r, 
                    y_train, 
                    batch_size = 64,
                    epochs = 100, 
                    validation_data=(X_valid_r, y_valid),
                    callbacks=callbacks_list,                    
                    shuffle=1,                    
                    verbose=1)

# save model
print("Saving model to disk \n")
model.save('/home/xuewen/Python/models/Model_SD_WIN.h5')

valdlossy = history.history['val_loss'] 
np_valdlossy = np.array(valdlossy).reshape((1, len(valdlossy)))
np.savetxt('/home/xuewen/Python/logs/val_loss.text', np_valdlossy)
   
trainlossy = history.history['loss']
np_lossy = np.array(trainlossy).reshape((1, len(trainlossy)))
np.savetxt('/home/xuewen/Python/logs/loss.text', np_lossy)





# 加载训练好的模型
model = load_model('/home/xuewen/Python/models/Model_SD_WIN.h5')  # train_model


X_test = np.array(test.values)


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
X_test_r[:, :, 9] = X_test[:, 3285:3650]
X_test_r[:, :, 10] = X_test[:, 3650:4015]
X_test_r[:, :, 11] = X_test[:, 4015:4380]
X_test_r[:, :, 12] = X_test[:, 4380:4745]
X_test_r[:, :, 13] = X_test[:, 4745:]

# 对测试数据进行预测
preds = model.predict(X_test_r, batch_size = 1)
print(preds)


output = np.vstack((preds)) #在垂直方向上堆叠
output = np.hstack((preds,Obs))  #在水平方向上堆叠
out_fname = '/home/xuewen/Python/predict/Pre_SD_WIN_A2008.csv'
#headers = ['Mo','Obs']
with open(out_fname, 'w', newline='')as f:
 f_csv = csv.writer(f)
# f_csv.writerow(headers)
 f_csv.writerows(output)
