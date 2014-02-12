#!/bin/bash

source ./func.sh

g_usage_arr[$((g_usage_off++))]="global_config"
global_config(){
    git config --global user.name "zhuhk"
    git config --global user.email "zhuhongk@gmail.com"
    git config --global credential.helper 'cache --timeout=360000'
    git config --global push.default simple
    return 0
}

g_usage_arr[$((g_usage_off++))]='multi'
multi(){

}

usage(){
    echo "Usage: $0 <ty> ... "
    for((i=0;i<g_usage_off;i++)){
	echo "  ${g_usage_arr[$i]}"
    }
}

g_cmd=$1
shift

ty=`type -t "$g_cmd"`
if [ -n "$ty" ];then
    "$g_cmd" "$@"
    ret=$?
else
    if [[ -n "$g_cmd" ]];then
	echo "ty:'$g_cmd' Not Defined" >&2
    fi
    usage
    ret=0
fi

if [ $ret -eq 2 ];then
    usage
elif [[ $ret -gt 2 ]];then
    log_fatal "ty=$ty ret=$?"
fi

exit $ret

