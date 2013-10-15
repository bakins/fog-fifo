require 'fog/compute/models/server'
module Fog
  module Compute
    class Fifo

      class Server < Fog::Compute::Server
        identity :uuid

        attribute :state
        attribute :hypervisor
        attribute :config

        def dataset
          requires :uuid
          @dataset ||= service.images.get(config["dataset"])
        end

        def ips
          requires :uuid
          config["networks"].map{|n| n["ip"]}
        end

        def memory
          requires :uuid
          config["ram"]
        end

      end
    end
  end
end
