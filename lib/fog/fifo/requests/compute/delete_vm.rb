module Fog
  module Compute
    class Fifo

      class Mock
        def delete_vm(uuid)
          if vm = self.data[:vms][uuid]
            res = Excon::Response.new
            res.status = 200
            res
          else
            raise Excon::Errors::NotFound, "Not Found"
          end
        end
      end

      class Real
        def delete_vm(id)
          request(
                  :method => "DELETE",
                  :path => "vms/#{id}",
                  :expects => [200]
                  )
        end
      end
    end
  end
end
