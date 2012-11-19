require 'yaml'
vcfg = YAML.load(File.read("#{File.expand_path("..", __FILE__)}.yml"))
Vagrant::Config.run do |cfg|
  cfg.vm.define File.basename(File.dirname(__FILE__)).to_sym do |config|
    config.vm.network :hostonly, vcfg["network"] if vcfg["network"]
    config.vm.box = vcfg["box"]
    config.vm.host_name = File.basename(File.dirname(__FILE__))
    config.ssh.username = "root"
    config.vm.provision :shell, :path => vcfg["provision"]
  end
end
