require 'fog/core/collection'
require 'fog/fifo/models/compute/package'

module Fog
  module Compute

    class Fifo
      class Packages < Fog::Collection

        model Fog::Compute::Fifo::Package

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
