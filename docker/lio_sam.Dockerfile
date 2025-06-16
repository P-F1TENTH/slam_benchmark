FROM ros_base

RUN apt-get update && apt-get install -y \
    ros-humble-perception-pcl \
    ros-humble-pcl-msgs \
    ros-humble-vision-opencv \
    ros-humble-xacro \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

RUN add-apt-repository -y ppa:borglab/gtsam-release-4.1 && \
    apt-get update && \
    apt-get install -y libgtsam-dev libgtsam-unstable-dev && \
    rm -rf /var/lib/apt/lists/*

RUN git clone -b ros2 https://github.com/TixiaoShan/LIO-SAM.git /workspace/LIO-SAM

RUN . /opt/ros/humble/setup.sh && \
    colcon build --symlink-install

CMD ["bash"]

