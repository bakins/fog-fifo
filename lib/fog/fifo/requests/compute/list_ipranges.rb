module Fog
  module Compute
    class Fifo

      class Mock
        def list_ipranges
          res = Excon::Response.new
          res.status = 200
          res.body = self.data[:ipranges].values
          res
        end
      end

      class Real
        def list_ipranges
          request(
            :path => "ipranges",
            :method => "GET",
            :expects => 200
          )
        end
      end
    end
  end
end
