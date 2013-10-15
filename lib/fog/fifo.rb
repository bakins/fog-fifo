require 'fog/core'

module Fog
  module Fifo
    extend Fog::Provider

    service(:compute, 'fifo/compute', 'Compute')

  end
end
