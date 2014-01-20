require 'fog/compute/models/server'
module Fog
  module Compute
    class Fifo

      class Server < Fog::Compute::Server
        identity :uuid

        attribute :state
        attribute :hypervisor
        attribute :config
        attribute :package
        attribute :network
	attribute :log

        def dataset
          requires :uuid
          config["dataset"]
        end

        #def package
        #  requires :uuid
        #  config["package"]
        #end

        def ips
          requires :uuid
          config["networks"].map{|n| n["ip"]}
        end

        def memory
          requires :uuid
          config["ram"]
        end

        def reboot
          requires :uuid
          service.reboot_vm(uuid)
          true
        end

        def stopped?
          requires :uuid
          self.state == 'stopped'
        end

        def stop
          requires :uuid
          service.stop_vm(uuid)
          self.wait_for { stopped? }
          true
        end

        def ready?
          self.state == 'running'
        end

        def start
          requires :uuid
          service.start_vm(uuid)
          self.wait_for { ready? }
          true
        end

	def delete
	  requires :uuid
	  service.delete_vm(uuid)
	  true
	end

      end
    end
  end
end
