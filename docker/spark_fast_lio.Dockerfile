FROM osrf/ros:jazzy-desktop

# Create workspace and clone spark-fast-lio
WORKDIR /root/ros2_ws/src
RUN git clone https://github.com/MIT-SPARK/spark-fast-lio.git

# Build the package
WORKDIR /root/ros2_ws
SHELL ["/bin/bash", "-c"]
RUN source /opt/ros/jazzy/setup.bash && \
    colcon build --packages-up-to spark_fast_lio

# Source environment on container start
RUN echo "source /opt/ros/jazzy/setup.bash" >> ~/.bashrc && \
    echo "source /root/ros2_ws/install/setup.bash" >> ~/.bashrc

CMD ["bash"]
