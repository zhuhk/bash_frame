== func.sh, 基础功能封装
  1. bash中支持日志功能。可以自动添加文件名、函数名、行号. 
     相关函数:
     - init_log: 指定日志文件名，若不指定不会写到文件中。会直接输出到stderr.
	 - log_fatal/log_warn/log_info: 带有不同前缀的函数
	 - logex: 上述3个函数的支持函数
	 - _log: 最底层的函数
  2. 相对路径转换成绝对路径(abs_path) : abs_path ..
  3. 比较两个文件是否相同:is_diff
  4. check_pipe_status, 使用管道执行多个命令时，通过这个函数可以检查所有命令是否都是正常退出
  5. queryip: 查询ip
  6. retry, 重试执行. retry <cmd ...>
  7. daemon, 后台启动命令, 启动脚本会退出，被执行的命令会一直执行直到结束. daemon <cmd ...>
  8. logrun, 启动时，自动打开日志文件,使用脚本的文件名和命令名称做日志的文件名. ./run.sh logrun ls => run_ls.log run_ls.err
  9. 上述几个命令可以组合起来. ./run.sh daemon retry logrun ls
  10. 上述命令，也可以在脚本中直接调用
 

== run.sh,示例模版，方便的在命令行中调用函数. 从易用性的角度来看，多个脚本比不上一个脚本带有多个命令及命令的使用说明方便
  1. 一个任务的执行需要多个命令，希望多个命令串行执行且支持断点时，可使用mutil()

== 小窍门
  1. 如果希望将命令保存到一个变量中，且命令的参数中有包括空格这种需要用""起来时，可以使用eval. 比如:
     cmd='mkdir "a b"'
     eval $cmd
