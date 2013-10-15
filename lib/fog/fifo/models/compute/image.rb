module Fog
  module Compute
    class Fifo
      class Image < Fog::Model

        identity :dataset

        attribute :name
        attribute :os
        attribute :type
        attribute :version
        attribute :description
        
      end
    end
  end
end
