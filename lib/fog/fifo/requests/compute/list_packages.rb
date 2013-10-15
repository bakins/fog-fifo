module Fog
  module Compute
    class Fifo

      class Mock
        def list_packages
          response = Excon::Response.new()
          response.status = 200
          response.body = self.data[:packages].values
          response
        end
      end

      class Real
        def list_packages
          request(
            :path => "packages",
            :method => "GET",
            :expects => 200
          )
        end
      end # Real

    end

  end
end
