module Fog
  module Compute
    class Fifo

      class Mock
        def start_vm(uuid)
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
        def create_vm(params)
          pp params
          request(
                  :method => "POST",
                  :path => "vms",
                  :expects => [200],
                  :body => params
                  )
        end
      end
    end
  end
end
