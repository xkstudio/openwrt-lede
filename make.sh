#!/bin/bash
# Build for K-Wrt
# Author: Xiaok
# Date: 2024-03-18
# Update: 2024-05-18

targets=build_config/targets.list
target_package_default=build_config/package/common.config
proxy_server="vpn.xk.com:1080"
export http_proxy=socks5://${proxy_server}
export https_proxy=socks5://${proxy_server}
export ftp_proxy=socks5://${proxy_server}
jobs=$(nproc)

function _log(){
    msg="[`date +'%F %T'`] $1"
    echo -e "\033[33m${msg}\033[39m"
}

function build(){
    _target=$(echo $1 | awk -F ' : ' '{print $1}')
    _target_name=$(echo $1 | awk -F ' : ' '{print $2}')
    _log "==================== ${_target_name} ===================="
    target_profile=build_config/target/${_target}.config
    target_package=build_config/package/${_target}.config
    [ -f ${target_package} ] || target_package=${target_package_default}
    _log "${_target_name} => Generate build config file ..."
    cat ${target_profile} ${target_package} > .config
    make defconfig
    backup_config_name="${_target}_`date +'%+4Y%m%d_%H%M'`".config
    [ -d configs ] || mkdir configs
    _log "${_target_name} => Backup .config file to configs/${backup_config_name} ..."
    cp .config configs/${backup_config_name}
    _log "${_target_name} => Make the world ..."
    make -j $jobs
    [ $? -eq 0 ] && _log "${_target_name} => Build completed."
}

function run_build(){
    build_time=`date +"%F %T"`
    date +%s > version.date
    echo ${build_time} > feeds/kwrt/kwrt-settings/files/build.time
    targets_num=$(cat ${targets} | wc -l)
    for i in `seq 1 ${targets_num}`
    do
        _target=$(sed -n ${i}p ${targets})
        echo $_target | grep -E '^#' > /dev/null 2>&1
        [ $? -eq 0 ] && continue
        build "$_target"
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

