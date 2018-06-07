FROM diluka/sfm-base

WORKDIR /opt

# Install OpenMVG
ADD OpenMVG ./OpenMVG
RUN mkdir -p /opt/OpenMVG_build \
    && cd /opt/OpenMVG_build \
    && cmake . /opt/OpenMVG/src/ -DCMAKE_BUILD_TYPE=RELEASE -DLEMON_ENABLE_SOPLEX=NO \
    && make && make install

# Install OpenMVS
ADD VCG ./VCG
ADD OpenMVS ./OpenMVS
RUN mkdir -p /opt/OpenMVS_build \
    && cd /opt/OpenMVS_build \
    && cmake . /opt/OpenMVS -DCMAKE_BUILD_TYPE=Release -DVCG_ROOT="/opt/VCG" -DCMAKE_CXX_FLAGS="-w" \
    && make && make install

# Install pipeline
ADD MvgMvs_Pipeline.py .
RUN chmod +x /opt/MvgMvs_Pipeline.py \
    && ln -s /opt/MvgMvs_Pipeline.py /usr/local/bin/mvgmvs

WORKDIR /root
