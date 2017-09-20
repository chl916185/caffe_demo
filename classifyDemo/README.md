1. 将classifyDemo整个文件夹拷贝到任意位置
2. 打开CMakeLists.txt文件，将变量Caffe_DIR设置为当前电脑中安装的caffe的路径
3. 打开src/classify.cpp文件，修改main函数中deploy.prototxt，bvlc_reference_caffenet.caffemodel，synset_words.txt，cat.jpg，imagenet_mean.binaryproto对应的
model_file/trained_file/label_file/img_file/mean_file值
4. 在终端下，cd 切换到当前目录下的build文件夹中
5. 执行cmake ..
6. 执行make
7. 执行./classify.o