module Fog
  module Compute
    class Fifo
      class Network < Fog::Model
        identity :uuid

        attribute :name
        attribute :version
        attribute :ipranges

      end
    end
  end
end
