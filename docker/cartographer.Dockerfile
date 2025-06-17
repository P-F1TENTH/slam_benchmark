FROM ros:humble

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    bash-completion \
    libogre1.12.10 \
    ros-humble-desktop \
    ros-humble-cartographer \
    ros-humble-cartographer-ros \
    ros-humble-rviz2 && \
    rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-c"]

RUN sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/g' /root/.bashrc && \
    echo '! shopt -oq posix && source /etc/bash_completion' >> /root/.bashrc && \
    echo 'export ROS_DOMAIN_ID=222' >> /root/.bashrc && \
    echo 'source /opt/ros/humble/setup.bash' >> /root/.bashrc && \
    echo 'source /root/ws/install/setup.bash' >> /root/.bashrc

WORKDIR /root/ws

CMD ["bash"]
