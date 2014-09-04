root = "/home/deployer/apps/hujia/current"
working_directory root
pid "#{root}/tmp/pids/unicorn_hujia.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.hujia.sock"
worker_processes 2
timeout 30