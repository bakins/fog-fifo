require 'fog/fifo/models/compute/network'
module Fog
  module Compute
    class Fifo
      class Networks < Fog::Collection

        model Fog::Compute::Fifo::Network

        def all
          service.list_networks().body.map{|id| get(id) }
        end

        def get(id)
          data = service.get_network(id).body
          new(data)
        end

      end
    end
  end
end
