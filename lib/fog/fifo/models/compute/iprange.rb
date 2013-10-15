module Fog
  module Compute
    class Fifo
      class Iprange < Fog::Model
        identity :uuid

        attribute :name
        attribute :version
        attribute :first
        attribute :last
        attribute :gateway
        attribute :netmask
        attribute :network
        attribute :tag
        attribute :vlan

      end
    end
  end
end
