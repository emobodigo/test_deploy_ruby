# This configuration file documents many features of Unicorn
# that may not be needed for some applications. See
# http://unicorn.bogomips.org/examples/unicorn.conf.minimal.rb
# for a much simpler configuration file.
#
# See http://unicorn.bogomips.org/Unicorn/Configurator.html for complete
# documentation.

worker_processes 4

################################################################################
# Adjust your APP_PATH here!!!
################################################################################
APP_PATH = "/home/imanhe/Projects/interbenua" # NO trailing slash

working_directory APP_PATH
listen APP_PATH + "/tmp/interbenua.infopibi.sock", :backlog => 64
listen 3002, :tcp_nopush => true
timeout 30
pid APP_PATH + "/tmp/pids/unicorn.pid"
stderr_path APP_PATH + "/log/unicorn.stderr.log"
stdout_path APP_PATH + "/log/unicorn.stdout.log"
preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true
before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end

