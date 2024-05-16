#!/bin/bash
# Build for K-Wrt
# Author: Xiaok
# Date: 2024-03-18
# Update: 2024-05-18

targets=$(cat targets.list | grep -Ev '^#')

target_packages_default=build_config/package/common.config

proxy_server="192.168.188.91:1080"
export http_proxy=socks5://${proxy_server}
export https_proxy=socks5://${proxy_server}
export ftp_proxy=socks5://${proxy_server}

jobs=$(nproc)

function _log(){
    msg="[`date +'%F %T'`] $1"
    echo -e "\033[33m${msg}\033[39m"
}

function build(){
    _target=$1
    _log "==================== ${_target} ===================="
    target_meta=build_config/target/${_target}.config
    target_packages=build_config/package/${_target}.config
    [ -f ${target_packages} ] || target_packages=${target_packages_default}
    _log "${_target} => Generate build config file ..."
    cat ${target_meta} ${target_packages} > .config
    make defconfig
    backup_config_name="${_target}_`date +'%+4Y%m%d_%H%M'`".config
    _log "${_target} => Backup .config file to configs/${backup_config_name} ..."
    cp .config configs/${backup_config_name}
    _log "${_target} => Run make world ..."
    make -j $jobs
    [ $? -eq 0 ] && _log "${_target} => Build completed."
}

function run_build(){
    build_time=`date +"%F %T"`
    date +%s > version.date
    echo ${build_time} > feeds/kwrt/kwrt-settings/files/build.time
    for i in $targets
    do
        build $i
    done
}

case $1 in
    #d|debug)
    #    echo -e "\033[36;49;1mDebug mode ...\033[39;49;0m"
    #    make V=sc -j 1
    #    #make V=s -j $jobs
    #;;
    p|pkg|package)
        echo -e "Build \033[36;49;1m$2\033[39;49;0m ..."
        make package/$2/compile V=sc -j 1
    ;;
    *)
	run_build
esac

