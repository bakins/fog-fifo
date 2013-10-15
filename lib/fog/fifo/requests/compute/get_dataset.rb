module Fog
  module Compute
    class Fifo

      class Mock
        def get_dataset(id)
          if ds = self.data[:datasets][id]
            res = Excon::Response.new
            res.status = 200
            res.body = ds
          else
            raise Excon::Errors::NotFound
          end
        end
      end

      class Real
        def get_dataset(id)
          request(
            :method => "GET",
            :path => "datasets/#{id}"
          )
        end
      end

    end
  end
end
