module Fog
  module Compute
    class Fifo
      class Mock

        def get_package(id)
          if pkg = self.data[:packages][id]
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
        def get_package(id)
          request(
            :method => "GET",
            :path => "packages/#{id}",
            :expects => 200
          )
        end

      end
    end
  end
end
