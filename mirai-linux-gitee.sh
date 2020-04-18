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
            git java-11-openjdk-devel
        )

        for pkg in ${yum_pkgs[@]}; do
            yum_install ${pkg}
        done

    elif [ -x "$(command -v apt-get)" ]; then
        apt_pkgs=(
            openjdk-11-jdk git
        )

        for pkg in ${apt_pkgs[@]}; do
            apt_install ${pkg}
        done

    fi
}

download_files() {
    echo -e "[${yellow}Info${plain}] Cloning files from gitee ..."
    git clone https://gitee.com/cyanray/mirai-linux.git tmp;
}

clean_up_files() {
    echo -e "[${yellow}Info${plain}] mkdir plugins"
    mkdir plugins
    echo -e "[${yellow}Info${plain}] mkdir content"
    mkdir content

    echo -e "[${yellow}Info${plain}] Copying files ..."
    cp ./tmp/mirai-console-wrapper-0.3.0.jar ./
    cp ./tmp/mirai-console-addition-V0.2.3.jar ./plugins/
    cp ./tmp/mirai-api-http-v1.6.3.jar ./plugins/

    echo -e "[${yellow}Info${plain}] Cleaning up files ..."
    rm -rf ./tmp
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
