require 'fog/fifo/models/compute/iprange'
module Fog
  module Compute
    class Fifo
      class Ipranges < Fog::Collection

        model Fog::Compute::Fifo::Iprange

        def all
          service.list_ipranges().body.map{|id| get(id) }
        end

        def get(id)
          data = service.get_iprange(id).body
          new(data)
        end

      end
    end
  end
end
