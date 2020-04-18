#!/usr/bin/env bash

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

[[ $EUID -ne 0 ]] && echo -e "[${red}Error${plain}] This script must be run as root!" && exit 1

download() {
    local filename=$(basename $1)
    if [ -f ${1} ]; then
        echo "[Info] ${filename} [found]"
    else
        echo "[Info] ${filename} not found, download it now..."
        wget --no-check-certificate -c -t3 -T60 -O ${1} ${2}
        # wget --no-check-certificate -q --show-progress -c -t3 -T60 -O ${1} ${2}
        if [ $? -ne 0 ]; then
            echo -e "[${red}Error${plain}] Download ${red}${filename}${plain} failed."
            exit 1
        fi
    fi
}

yum_install() {
    local pkg_name=$1
    echo -e "[${yellow}Info${plain}] Starting to install ${green}${pkg_name}${plain}"
    yum -y install ${pkg_name} >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo -e "[${red}Error${plain}] Failed to install ${red}${pkg_name}${plain}"
        exit 1
    fi
}

apt_install() {
    local pkg_name=$1
    echo -e "[${yellow}Info${plain}] Starting to install ${green}${pkg_name}${plain}"
    apt-get -y install openjdk-11-jdk >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo -e "[${red}Error${plain}] Failed to install ${red}${pkg_name}${plain}"
        exit 1
    fi
}

install_pkgs() {
    if [ -x "$(command -v yum)" ]; then

        yum_pkgs=(
            wget java-11-openjdk-devel
        )

        for pkg in ${yum_pkgs[@]}; do
            yum_install ${pkg}
        done

    elif [ -x "$(command -v apt-get)" ]; then
        apt_pkgs=(
            openjdk-11-jdk wget
        )

        for pkg in ${apt_pkgs[@]}; do
            apt_install ${pkg}
        done

    fi
}

download_files() {
    echo -e "[${yellow}Info${plain}] Downloading ${green}mirai-console-wrapper-0.3.0.jar${plain} ..."
    download "mirai-console-wrapper-0.3.0.jar" "https://webplus-cn-hangzhou-s-5e5a2d1c60533f0bea484374.oss-cn-hangzhou.aliyuncs.com/mirai-console-wrapper-0.3.0.jar"

    echo -e "[${yellow}Info${plain}] Downloading ${green}mirai-console-addition-V0.2.3.jar${plain} ..."
    download "mirai-console-addition-V0.2.3.jar" "https://webplus-cn-hangzhou-s-5e5a2d1c60533f0bea484374.oss-cn-hangzhou.aliyuncs.com/mirai-console-addition-V0.2.3%20%281%29.jar"

    echo -e "[${yellow}Info${plain}] Downloading ${green}mirai-api-http-v1.6.3.jar${plain} ..."
    download "mirai-api-http-v1.6.3.jar" "https://webplus-cn-hangzhou-s-5e5a2d1c60533f0bea484374.oss-cn-hangzhou.aliyuncs.com/mirai-api-http-v1.6.3.jar"
}

clean_up_files() {
    echo -e "[${yellow}Info${plain}] mkdir plugins"
    mkdir plugins
    echo -e "[${yellow}Info${plain}] mkdir content"
    mkdir content

    echo -e "[${yellow}Info${plain}] Copying files ..."
    cp mirai-console-addition-V0.2.3.jar ./plugins/
    cp mirai-api-http-v1.6.3.jar ./plugins/

    echo -e "[${yellow}Info${plain}] Cleaning up files ..."
    rm mirai-console-addition-V0.2.3.jar
    rm mirai-api-http-v1.6.3.jar
}

config_mirai() {
    echo -e " "
}

start_mirai() {
    echo -e "[${yellow}Info${plain}] Starting ${green}mirai-console-wrapper${plain} ..."
    chmod +x ./mirai-console-wrapper-0.3.0.jar
    java -jar ./mirai-console-wrapper-0.3.0.jar
}

# install process
install_pkgs
download_files
clean_up_files
config_mirai
start_mirai
