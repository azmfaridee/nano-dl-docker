FROM nvcr.io/nvidia/l4t-base:r32.3.1

LABEL maintainer="ABU ZAHER MD FARIDEE <zaher14@gmail.com>"

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
        python3-setuptools \
	libopenblas-base

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
	google-pasta \
	Cython \
	numpy


RUN pip3 --no-cache-dir install --pre -v --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v42 \
	tensorflow-gpu==2.0.0+nv19.11
	
RUN curl -L https://nvidia.box.com/shared/static/ncgzus5o23uck9i5oth2n8n06k340l6k.whl > /tmp/torch-1.4.0-cp36-cp36m-linux_aarch64.whl && \
	pip3 --no-cache-dir -v install /tmp/torch-1.4.0-cp36-cp36m-linux_aarch64.whl && \
	rm  /tmp/torch-1.4.0-cp36-cp36m-linux_aarch64.whl

EXPOSE 8888 6006

RUN mkdir -p /notebooks

CMD ["jupyter", "notebook", "--no-browser", "--ip=0.0.0.0", "--allow-root", "--notebook-dir='/notebooks'"]

