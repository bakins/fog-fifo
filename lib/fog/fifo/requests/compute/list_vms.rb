module Fog
  module Compute
    class Fifo

      class Mock
        def list_vm
          res = Excon::Response.new
          res.status = 200
          res.body = self.data[:machines].values
          res
        end
      end

      class Real
        def list_vms(options={})
          request(
            :path => "vms",
            :method => "GET",
            :query => options,
            :expects => 200
          )
        end
      end
    end
  end
end
