# SLAM Benchmark

## Setup

Clone the repository:
```
git clone --recursive git@github.com:PUT-F1TENTH/slam_benchmark.git
```

Build the container:
```
./build.sh
```

Run the container:
```
./run.sh
```

Build the workspace:
```
cd /root/ws
colcon build --symlink-install
```

Run:
```
ros2 launch launch/slam_benchmark_ros.launch.py
```
