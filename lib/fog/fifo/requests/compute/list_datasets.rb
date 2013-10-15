module Fog
  module Compute
    class Fifo

      class Mock
        def list_datasets
          res = Excon::Response.new
          res.status = 200
          res.body = self.data[:datasets].values
          res
        end
      end

      class Real
        def list_datasets
          request(
            :method => "GET",
            :path => "datasets"
          )
        end
      end
    end
  end
end
