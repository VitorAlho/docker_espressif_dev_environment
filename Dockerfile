
FROM ubuntu:latest

RUN echo "\n	          											\
\n ######################################################################                           \
\n ################  ESPRESSIF DEVELOPMENT ENVIRONMENT  #################				\
\n ######################################################################				\
\n #													\
\n #  09/01/2022											\
\n #  Author: Vitor Alho										\
\n #  E-mail: vitoralho1@gmail.com									\
\n #													\
\n #  Welcome to this espressif development environment!						\
\n #  													\
\n #  Before continue, check if you bind mapped your project directory to this container		\
\n #													\
\n #  Like this: sudo docker run -it -v host/folder:/projects --name esp_environment vitor19897/espressif_dev_environment \
\n #  													\
\n #  If you want to be able to flash your esp board from this container, remember			\
\n #  to put it in your command or run with root privileges						\
\n #													\
\n #  Like this: docker run -t -i --device=/dev/ttyUSB0 vitor19897/espressif_dev_environment	\
\n #  or												\
\n #  Like this: docker run -t -i --privileged  vitor19897/espressif_dev_environment		\
\n #													\
\n ###################################################################### 				\
\n #													\
\n #  First, you need to select your favorite esp sdk, so it will include all path variables	\
\n #  to compile your code.										\
\n # 													\
\n #  Those are available SDK's:									\
\n # 													\
\n #  For ESP32											\
\n # 													\
\n #     * v4.2											\
\n #      												\
\n #     Type 'use_esp32_v4.2' inside command prompt and press 'enter'				\
\n #   												\
\n #  For ESP8266											\
\n #													\
\n #     * not yet supported										\
\n #													\
\n #     Type 'use_esp8266_v?.?' inside command prompt and press 'enter'				\
\n #													\
\n ######################################################################">readme.txt

RUN echo "\n          											\
cat /readme.txt \n											\
alias use_esp32_v4.2='unset IDF_PATH && unset IDF_TOOLS_PATH && export IDF_TOOLS_PATH='"'/esp32_sdk/v4.2/.espressif'"' && . ./esp32_sdk/v4.2/esp-idf/export.sh'">/root/.bash_aliases

RUN apt-get update --fix-missing

RUN DEBIAN_FRONTEND='noninteractive' apt-get install -y apt-utils git python3 python3-pip libusb-1.0-0 nano make cmake && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 40 && \
    cd /                                                           && \
    mkdir esp32_sdk                                                && \
    cd esp32_sdk                                                   && \
    mkdir v4.2                                                     && \
    cd v4.2                                                        && \
    git clone https://yourAuthKey:x-oauth-basic@github.com/espressif/esp-idf.git     && \
    cd esp-idf                                                     && \    
    git reset --hard v4.2		                            && \
    export IDF_TOOLS_PATH='/esp32_sdk/v4.2/.espressif'             && \
    export IDF_PATH=/esp32_sdk/v4.2/esp-idf			     && \
    ./install.sh		                                    && \
    . ./export.sh                                                  && \
    cd /esp32_sdk/v4.2/esp-idf/examples/get-started/blink	     && \
    idf.py build

