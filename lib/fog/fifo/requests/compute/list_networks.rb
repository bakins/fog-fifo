module Fog
  module Compute
    class Fifo

      class Mock
        def list_networks
          res = Excon::Response.new
          res.status = 200
          res.body = self.data[:networks].values
          res
        end
      end

      class Real
        def list_networks
          request(
            :path => "networks",
            :method => "GET",
            :expects => 200
          )
        end
      end
    end
  end
end
