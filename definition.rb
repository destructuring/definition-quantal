require 'yaml'
Veewee::Session.declare(YAML.load(File.read(File.join(File.dirname(File.expand_path(__FILE__)), "config/definition.yml"))))
