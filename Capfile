#!/usr/bin/env ruby

require 'alpha_omega/deploy'

# application deploy
namespace :ubuntu do
  task :overrides do
    set :skip_scm, false
    if ENV["_AO_WORKAREA"]
      set :deploy_to, ENV["_AO_WORKAREA"]
    else
      set(:deploy_to) { %x(pwd).chomp.sub("definitions", "vagrant") }
    end
  end

  task :restart do
    run "cd #{deploy_to} && #{ruby_loader} bin/restart vagrant"
  end

  task :hack do
    run "[[ -d #{deploy_release}/.git ]] || rm -rf #{deploy_release}/log"
    run "[[ -d #{deploy_release}/.git ]] || rmdir #{deploy_release}/cache"
    run "[[ -d #{deploy_release}/.git ]] || rmdir #{deploy_release}/service"
  end
end

namespace :deploy do
  task :bundle do
    run "cd #{deploy_release} && #{ruby_loader} bin/build ruby"
  end
end

# hooks into alpha_omega deploy
after "deploy:localdomain", "ubuntu:overrides"
before "deploy:update_code", "ubuntu:hack"
after "deploy:cook", "microwave:cook"
after "deploy:restart", "ubuntu:restart"

# interesting hosts
Deploy self, __FILE__ do |admin, node| 
  { :deploy => { } }
end

set :user, ENV['LOGNAME']
set :group, ENV['LOGNAME']
set :skip_scm, false
