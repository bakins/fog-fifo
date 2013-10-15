require 'fog/core/collection'
require 'fog/fifo/models/compute/flavor'

module Fog
  module Compute

    class Fifo
      class Flavors < Fog::Collection

        model Fog::Compute::Fifo::Flavor

        def all
          service.list_packages().body.map{|id| get(id) }
        end

        def get(id)
          data = service.get_package(id).body
          new(data)
        end

      end
    end # Fifo

  end # Compute
end # Fog
