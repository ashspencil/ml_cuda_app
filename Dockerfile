### Fix Cudnn7.1 to 7.0
FROM 56240d7febea

MAINTAINER ashspencil <pencil302@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN groupadd -g 3000 aigroup && \
    useradd -m -u 3001 -g 3000 -s /bin/bash aiuser01 && \
    chmod 750 /home/aiuser01 && \

    echo aiuser01:aiuser01aiuser01 | chpasswd && \
    echo root:aitroot | chpasswd && \

    apt-get update&& apt-get upgrade -y && \
    apt-get install -y --no-install-recommends apt-utils && \
    apt-get install -y net-tools && \
    apt-get install -y iputils-ping  && \
    apt-get install -y vim nano && \
    apt-get install -y openssh-server

### Python3.6
RUN apt-get update -y && \
    apt-get install -y software-properties-common python-software-properties && \
    add-apt-repository ppa:jonathonf/python-3.6 -y && \
    apt-get update -y && \
    apt-get install -y python3.6 python3.6-dev && \
    cd /usr/bin/ ; rm python3 ; ln -s python3.6 python3
    
### Tensorflow v1.6.0
RUN apt-get install -y python3-pip  && \
    pip3 install tensorflow-gpu==1.6

### keras
RUN pip3 install keras==2.1 && \
    pip3 install numpy scipy && \
    pip3 install -U scikit-learn==0.19.2 && \
    pip3 install pillow && \
    pip3 install h5py && \
    pip3 install Theano
    
### pytorch
#RUN pip3 install http://download.pytorch.org/whl/cu90/torch-0.3.1-cp36-cp36m-linux_x86_64.whl && \
RUN pip3 install torch torchvision

### pandas 
RUN pip3 install pandas==0.23.4

### tqdm
RUN pip3 install tqdm

### R for 3.4.4
RUN apt-get update -y && \
    apt-get install -y build-essential fort77 xorg-dev liblzma-dev  libblas-dev gfortran gcc-multilib gobjc++ aptitude && \
    aptitude install -y libreadline-dev && \
    aptitude install -y libcurl4-openssl-dev && \
    apt-get install -y texlive-latex-base libcairo2-dev  && \
    apt-get install -y apt-transport-https && \
    apt-get install -y software-properties-common && \
    cd /usr/lib/python3/dist-packages/ ; cp apt_pkg.cpython-35m-x86_64-linux-gnu.so apt_pkg.so && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && \
    add-apt-repository "deb [arch=amd64,i386] https://cran.rstudio.com/bin/linux/ubuntu xenial/" && \
    apt-get update -y && \
    apt-get -y install r-base=3.4.4-1xenial0

### install git
RUN wget https://github.com/git/git/archive/v2.17.1.zip -O git.zip && \
    apt-get install -y unzip make zlib1g-dev tcl-dev libssl-dev gettext && \
    unzip git.zip && \
    apt-get install -y autoconf && \
    make -C git-2.17.1/ configure && \
    ./git-2.17.1/configure --prefix=/usr/local && \
    make -C git-2.17.1/ prefix=/usr/local install && \
    git --version

### Caffe2 Dependencies
RUN apt-get update -y && \
    apt-get install -y cmake libgoogle-glog-dev libgtest-dev liblmdb-dev libopencv-dev libopenmpi-dev libsnappy-dev libprotobuf-dev openmpi-bin openmpi-doc protobuf-compiler libgflags-dev && \
    pip3 install future && \
    pip3 install protobuf
    
### important 16.04
#RUN apt install -y --no-install-recommends libgflags-dev

### clone && build
RUN git clone --recursive https://github.com/pytorch/pytorch.git && \
    cd /usr/bin/ ; rm python ; ln -s python3.6 python
WORKDIR pytorch
RUN git submodule update --init && \
    mkdir build
WORKDIR build

RUN cmake .. -DUSE_MPI=OFF --no-warn-unused-cli && \
    make install
WORKDIR /

## oracle java 8 
RUN apt-get install -y software-properties-common debconf-utils && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update -y && \
    echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
    apt-get install -y oracle-java8-installer && \
    echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> /etc/profile && \
    echo "export JRE_HOME=/usr/lib/jvm/java-8-oracle/jre" >> /etc/profile && \
    apt-get install oracle-java8-set-default -y 

ENTRYPOINT service ssh restart && bash 
