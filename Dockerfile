FROM ubuntu:16.04

# Fetch dependencies from apt-get
RUN apt-get update 
RUN apt-get install -y cmake git libpng-dev libjpeg-dev libtiff-dev libglu1-mesa-dev libxxf86vm-dev libxxf86vm1 libxmu-dev libxi-dev libxrandr-dev gcc gcc-multilib
RUN apt-get install -y libopencv-dev
RUN apt-get install -y libboost-all-dev
RUN apt-get install -y libcgal-dev libcgal-qt5-dev
RUN apt-get install -y libgoogle-glog-dev
RUN apt-get install -y python-dev python-pip
RUN apt-get install -y libsuitesparse-dev libatlas-base-dev 
RUN apt-get install -y freeglut3-dev libglew-dev libglfw3-dev graphviz

WORKDIR /opt

# Install Eigen
# RUN apt-get install -y libeigen3-dev
ADD eigen ./eigen
RUN mkdir -p /opt/eigen_build && cd /opt/eigen_build \
    && cmake . /opt/eigen \
    && make && make install

# Install Ceres
# RUN apt-get install -y libceres-dev
ADD ceres-solver ./ceres-solver
RUN mkdir -p /opt/ceres_build \
    && cd /opt/ceres_build \
    && cmake . /opt/ceres-solver/ -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF \
    && make && make install 

# Install OpenMVG
ADD OpenMVG ./OpenMVG
RUN mkdir -p /opt/OpenMVG_build \
    && cd /opt/OpenMVG_build \
    && cmake . /opt/OpenMVG/src/ -DCMAKE_BUILD_TYPE=RELEASE -DLEMON_ENABLE_SOPLEX=NO -DCMAKE_INSTALL_PREFIX="/opt/OpenMVG_build/install" \
    && make && make install

# Install OpenMVS
ADD VCG ./VCG
ADD OpenMVS ./OpenMVS
RUN mkdir -p /opt/OpenMVS_build \
    && cd /opt/OpenMVS_build \
    && cmake . /opt/OpenMVS -DCMAKE_BUILD_TYPE=Release -DVCG_ROOT="/opt/VCG" \
    && make && make install

# Install pipeline
ADD MvgMvs_Pipeline.py .
RUN ln -s ./MvgMvs_Pipeline.py /usr/local/bin/mvgmvs

WORKDIR /root
