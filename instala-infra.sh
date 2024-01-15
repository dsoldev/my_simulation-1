######################################################
### Script de instalacao da infra 2024-1 - Lab 404 ###
######################################################


# Preparacao para instalacao do ROS2 - Humble

locale  # check for UTF-8

sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

export LANG=en_US.UTF-8

locale  # verify settings
sudo apt install software-properties-common -y
sudo add-apt-repository universe -y
sudo apt update && sudo apt install curl -y

# Instalacao do repositorio e chaves do ROS
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
sudo apt update && sudo apt upgrade -y

# Instalacao do ROS2 Humble Desktop
sudo apt install -y ros-humble-desktop ros-dev-tools

# Instalacao do turtlebot
sudo apt install -y ros-humble-gazebo-*
sudo apt install -y ros-humble-cartographer
sudo apt install -y ros-humble-cartographer-ros
sudo apt install -y ros-humble-navigation2
sudo apt install -y ros-humble-nav2-bringup
source ~/.bashrc
sudo apt install -y ros-humble-dynamixel-sdk
sudo apt install -y ros-humble-turtlebot3-msgs
sudo apt install -y ros-humble-turtlebot3
echo '##################################################' >> ~/.bashrc
echo '### Adicionado 3o Sem Comp 2024 - Lab 404 - INF ###' >> ~/.bashrc
echo 'source ~/robotica.sh' >> ~/.bashrc
echo '##################################################' >> ~/.bashrc
source ~/.bashrc

# Instalacao do colcon
sudo apt install -y python3-colcon-common-extensions
mkdir -p ~/colcon_ws/src
cd ~/colcon_ws/src
git clone -b humble-devel https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git
git clone -b humble-devel https://github.com/ROBOTIS-GIT/turtlebot3_manipulation.git
# git clone -b humble-devel https://github.com/ROBOTIS-GIT/turtlebot3.git 
# git clone -b humble-devel https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git 
# git clone -b humble-devel https://github.com/ROBOTIS-GIT/DynamixelSDK.git 

# Criacao do robotica.sh
touch ~/robotica.sh
cat <<EOF > ~/robotica.sh
alias update="sudo apt update && sudo apt upgrade -y && sudo apt autoremove"

###########################################
### variaveis relacionadas ao ROS2 Humble
source /opt/ros/humble/setup.bash
source ~/colcon_ws/install/setup.bash
export ROS_DOMAIN_ID=30 #TURTLEBOT3
export TURTLEBOT3_MODEL=burger_insper
###
###########################################

###########################################
### extras do colcon
source /usr/share/colcon_cd/function/colcon_cd.sh
alias cdc="cd ~/colcon_ws"
alias nb="nano ~/.bashrc"
alias nr="nano ~/robotica.sh"
alias cb="cd ~/colcon_ws && colcon build && source install/setup.bash"
###
###########################################
EOF