$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../lib'))
require 'fog/fifo'
require 'pp'
connection = Fog::Compute.new(
                              :provider => 'Fifo',
                              :fifo_username => ENV['FIFO_USERNAME'],
                              :fifo_password => ENV['FIFO_PASSWORD'],
                              :fifo_url => ENV['FIFO_URL']
                              )

pp connection.datasets.all
pp connection.packages.all
pp connection.networks.all
pp connection.ipranges.all
pp connection.servers.all

