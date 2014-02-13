#!/bin/bash

module=web_util/core_title

workdir=$(cd $(dirname $BASH_SOURCE) && pwd)

func_sh=$workdir/func.sh
if [ -f "$func_sh" ];then
	source $func_sh
else
	echo "[FATAL] func.sh NotFound, Quit"
	exit 1
fi

#_app_func_sh=$(cd $(dirname $BASH_SOURCE) && pwd)/app_func_project.sh
#if [ -n "$_app_func_sh"] && [ -f "$_app_func_sh" ];then
#	source "$_app_func_sh"
#fi


g_usage_arr[$((g_usage_off++))]="test_func"
test_func(){
	log_info "test for fun"
	return 0
}

#defined in share app_func.sh. Redefined Here will be ok
g_usage_arr[$((g_usage_off++))]="app_func"

main "$@"

