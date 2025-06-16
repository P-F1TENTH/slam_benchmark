FROM ros:noetic

ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/g' /root/.bashrc && \
    echo '! shopt -oq posix && source /etc/bash_completion' >> /root/.bashrc && \
    echo 'export ROS_DOMAIN_ID=222' >> /root/.bashrc && \
    echo 'source /opt/ros/noetic/setup.bash' >> /root/.bashrc && \
    echo 'source /root/ros2_ws/devel/setup.bash' >> /root/.bashrc

RUN apt-get update && \
    apt-get install -y \
    bash-completion \
    git \
    libpcl-dev \
    libyaml-cpp-dev \
    python3-catkin-tools \
    ros-noetic-catkin \
    ros-noetic-cv-bridge \
    ros-noetic-image-transport \
    ros-noetic-pcl-conversions \
    ros-noetic-rviz && \
    rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-c"]

RUN mkdir -p /root/ros2_ws/src && \
    cd /root/ros2_ws/src && \
    git clone https://github.com/g-ch/mask_kpts_msgs.git && \
    git clone --recursive https://github.com/tud-amr/semantic_dsp_map.git

WORKDIR /root/ros2_ws

RUN source /opt/ros/noetic/setup.bash && catkin build

CMD ["bash"]

# roslaunch semantic_dsp_map zed2.launch
