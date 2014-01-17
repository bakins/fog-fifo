module Fog
  module Compute
    class Fifo

      class Mock
        def remoot_vm(uuid)
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
        def reboot_vm(id)
          request(
                  :method => "PUT",
                  :path => "vms/#{id}",
                  :expects => [200],
                  :body => {"action" => "reboot"},
                  )
        end
      end
    end
  end
end
