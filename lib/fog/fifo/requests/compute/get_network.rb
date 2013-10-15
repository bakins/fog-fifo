module Fog
  module Compute
    class Fifo
      class Mock

        def get_network(id)
          if pkg = self.data[:networks][id]
            response = Excon::Response.new
            response.body = pkg
            response.status = 200
            response
          else
            raise Excon::Errors::NotFound
          end
        end
      end

      class Real
        def get_network(id)
          request(
                  :method => "GET",
                  :path => "networks/#{id}",
                  :expects => 200
                  )
        end

      end
    end
  end
end
