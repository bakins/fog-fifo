require 'fog/core'

#For https endpoints...
Excon.defaults[:ssl_verify_peer] = false

module Fog
  module Fifo
    extend Fog::Provider

    service(:compute, 'fifo/compute', 'Compute')

  end
end
