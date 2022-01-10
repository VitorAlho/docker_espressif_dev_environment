This is only a Dockerfile to build espressif development environment for ESP32 and ESP8266

Please download this repository and run this command with docker inside the dockerfile directory:

sudo docker build -t espressif_dev_environment .

After a sucefully build, use docker run command to create a container. If you want to flash your dev board from this
container, please use '--privileged' tag.

sudo docker run -itd -v your/host/directory:/projects --privileged --name esp_environment espressif_dev_environment

