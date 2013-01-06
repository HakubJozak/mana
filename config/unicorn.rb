# Minimal sample configuration file for Unicorn (not Rack) when used
# with daemonization (unicorn -D) started in your working directory.
#
# See http://unicorn.bogomips.org/Unicorn/Configurator.html for complete
# documentation.
# See also http://unicorn.bogomips.org/examples/unicorn.conf.rb for
# a more verbose configuration using more features.

listen 8080
worker_processes 2 # this should be >= nr_cpus
pid "/home/ubuntu/mana/shared/pids/unicorn.pid"
stderr_path "/home/ubuntu/mana/shared/log/unicorn.log"
stdout_path "/home/ubuntu/mana/shared/log/unicorn.log"
