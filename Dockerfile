FROM nvcr.io/nvidia/l4t-base:r32.2.1

MAINTAINER ABU ZAHER MD FARIDEE <zaher14@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        libfreetype6-dev \
        libhdf5-dev \
        libpng-dev \
        libzmq3-dev \
        pkg-config \
        python3-dev \
        python3-numpy \
        python3-scipy \
        python3-sklearn \
        python3-matplotlib \
        python3-pandas \
        rsync \
        unzip \
        zlib1g-dev \
        zip \
        libjpeg8-dev \
        hdf5-tools \
        libhdf5-serial-dev \
        python3-pip \
        python3-setuptools

RUN  apt-get clean && \
        rm -rf /var/lib/apt/lists/*

RUN pip3 install -U pip -v

RUN pip3 --no-cache-dir install -U -v \
	jupyter \
        grpcio \
        absl-py \
        py-cpuinfo \
        psutil \
        portpicker \
        six mock \
        requests \
        gast \
        h5py \
        astor \
        termcolor \
        protobuf \
        keras \
        keras-applications \
        keras-preprocessing \
        wrapt \
	google-pasta

RUN pip3 --no-cache-dir install --pre -v --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v42 \
	tensorflow-gpu==1.14.0+nv19.10

RUN curl -L https://nvidia.box.com/shared/static/phqe92v26cbhqjohwtvxorrwnmrnfx1o.whl > /tmp/torch-1.3.0-cp36-cp36m-linux_aarch64.whl && \
	pip3 --no-cache-dir -v install /tmp/torch-1.3.0-cp36-cp36m-linux_aarch64.whl && \
	rm  /tmp/torch-1.3.0-cp36-cp36m-linux_aarch64.whl

EXPOSE 8888 6006

RUN mkdir -p /notebooks

CMD ["jupyter", "notebook", "--no-browser", "--ip=0.0.0.0", "--allow-root", "--notebook-dir='/notebooks'"]

