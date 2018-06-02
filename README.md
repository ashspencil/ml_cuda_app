# ml_cuda_app
base on nvcr.io/nvidia/cuda img, tensorflow and another application

## include
* Ubuntu 16.04 
* CUDA9.0
* CUDNN7.1

* Keras 2.1.5
* PyTorch v0.3.1
* TensorFlow v1.6.0
* Python: 3.6 
* Caffe2
* R language v 3.4.4
* oracle Java 8 

Dockerhub

>ashspencil/ml_cuda_app(https://hub.docker.com/r/ashspencil/ml-cuda-app/)

```
docker pull ashspencil/ml-cuda-app

```
## usage

1.change the username and password by you want on Line 6, and remember to use NV_GPU='?' with nvidia-docker , like 

```
NV_GPU='0' nvidia-docker run -ti (image) /bin/bash
```

> [Nvidia-docker](https://github.com/NVIDIA/nvidia-docker)

2.OR you can modify anything.

3.Enjoy yourself !!

#If there is a problem or bug , just issue me :)
