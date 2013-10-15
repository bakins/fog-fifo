module Fog
  module Compute
    class Fifo
      class Flavor < Fog::Model

        identity :uuid

        attribute :name
        attribute :ram
        attribute :quota
        attribute :cpu_cap
        attribute :version

      end
    end
  end
end
