app_func(){
	ty=`type -t "log_info"`
	if [ -n "$ty" ];then
		log_info "functions for Special AppEnv"
	else
		echo "[$BASH_SOURCE,$FUNCNAME()] functions for Special AppEnv"
	fi
	return 0
}

