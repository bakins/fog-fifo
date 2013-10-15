require 'fog/core/collection'
require 'fog/fifo/models/compute/image'

module Fog
  module Compute

    class Fifo
      class Images < Fog::Collection

        model Fog::Compute::Fifo::Image

        def all
          service.list_datasets().body.map{|id| get(id) }
        end

        def get(id)
          data = service.get_dataset(id).body
          new(data)
        end

      end # Images
    end # Fifo

  end # Compute
end # Fog
