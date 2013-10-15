module Fog
  module Compute
    class Fifo
      class Mock

        def get_iprange(id)
          if pkg = self.data[:iprange][id]
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
        def get_iprange(id)
          request(
                  :method => "GET",
                  :path => "ipranges/#{id}",
                  :expects => 200
                  )
        end

      end
    end
  end
end
