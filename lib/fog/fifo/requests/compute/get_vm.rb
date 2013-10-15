module Fog
  module Compute
    class Fifo

      class Mock
        def get_vm(uuid)
          if vm = self.data[:vms][uuid]
            res = Excon::Response.new
            res.status = 200
            res.body = vm
            res
          else
            raise Excon::Errors::NotFound, "Not Found"
          end
        end
      end

      class Real
        def get_vm(id)
          request(
                  :method => "GET",
                  :path => "vms/#{id}",
                  :expects => [200]
                  )
        end
      end
    end
  end
end
