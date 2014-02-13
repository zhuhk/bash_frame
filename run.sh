#!/bin/bash

source $(cd $(dirname $BASH_SOURCE&&pwd))/func.sh

g_usage_arr[$((g_usage_off++))]="global_config"
global_config(){
    git config --global user.name "zhuhk"
    git config --global user.email "zhuhongk@gmail.com"
    git config --global credential.helper 'cache --timeout=360000'
    git config --global push.default simple
    return 0
}

g_usage_arr[$((g_usage_off++))]='multi [enable:0|1]#to run mult tasks'
multi(){
    if is_running "" 30;then
	log_warn "another instance is running. quit"
	return 1
    fi
    declare -i enable_bp="$1"
    dir=data/$FUNCNAME
    mkdir -p $dir
    dir=$(abs_path $dir)
    log_info "dir=$dir"
    status="running"
    if [[ $enable_bp -eq 0 ]];then
	echo "status=running" >$dir/bp.txt
    else
	source $dir/bp.txt
    fi
    if [[ "$status" = "succ" ]];then
	enable_bp=0
	echo "status=running" >$dir/bp.txt
    elif [[ "$status" != "running" ]];then
	echo "status=running" >>$dir/bp.txt
    fi
    taskcnt=0
    tasks[$((taskcnt++))]="ls"
    tasks[$((taskcnt++))]="mkdir -p data/test"

    for((i=0;i<taskcnt;i++)){
	log_info "try to run tasks[$i]='${tasks[$i]}'"
	echo "cmd[$i]='${tasks[$i]}'" >>$dir/bp.txt
	echo "bp[$i]=fail" >>$dir/bp.txt
	if [[ $enable_bp -gt 0 ]] && [[ ${bp[$i]} = "succ" ]] && [[ ${cmd[$i]} = ${tasks[$i]} ]];then
	    log_info "reuse tasks[$i]='${tasks[$i]}'"
	    echo "bp[$i]=succ" >>$dir/bp.txt
	    continue
	fi
	if retry eval ${tasks[$i]};then
	    log_info "succ to run tasks[$i]='${tasks[$i]}'"
	    echo "bp[$i]=succ" >>$dir/bp.txt
	else
	    log_fatal "fail to run tasks[$i]='${tasks[$i]}'"
	    echo "bp[$i]=fail" >>$dir/bp.txt
	    echo "status=fail" >>$dir/bp.txt
	    return 1
	fi
    }
    echo "status=succ" >>$dir/bp.txt
    return 0
}

main "$@"

