require 'fog/fifo'
#require 'fog/joyent/errors'
require 'fog/compute'
require 'pp'

module Fog
  module Compute
    class Fifo < Fog::Service
      requires :fifo_username

      requires :fifo_password
      requires :fifo_url

      model_path 'fog/fifo/models/compute'
      request_path 'fog/fifo/requests/compute'

      # Datasets
      collection :datasets
      model :dataset
      request :list_datasets
      request :get_dataset

      # packages
      collection :packages
      model :package
      request :list_packages
      request :get_package

      # Servers
      collection :servers
      model :server
      request :list_vms
      request :get_vm
      if false
      request :create_machine
      request :start_machine
      request :stop_machine
      request :reboot_machine
      request :resize_machine
      request :delete_machine
      end

      # Networks
      collection :networks
      model :network
      request :list_networks
      request :get_network

      # Ipranges
      collection :ipranges
      model :iprange
      request :list_ipranges
      request :get_iprange

      class Mock
        def self.data
          @data ||= Hash.new do |hash, key|
            hash[key] = {}
          end
        end

        def data
          self.class.data
        end

        def initialize(options = {})
          @fifo_username = options[:fifo_username] || Fog.credentials[:fifo_username]
          @fifo_password = options[:fifo_password] || Fog.credentials[:fifo_password]
        end

        def request(opts)
          raise "Not Implemented"
        end
      end # Mock

      class Real
        def initialize(options = {})

          @connection_options = options[:connection_options] || {}
          @persistent = options[:persistent] || false

          @fifo_username = options[:fifo_username]

          unless @fifo_username
            raise ArgumentError, "options[:fifo_username] required"
          end

          @fifo_url = options[:fifo_url]

          unless @fifo_url
            raise ArgumentError, "options[:fifo_url] required"
          end

          @fifo_password = options[:fifo_password]

          unless @fifo_password
            raise ArgumentError, "options[:fifo_password] required"
          end

          @fifo_password = options[:fifo_password]

          @fifo_token = nil

          @fifo_uri = ::URI.parse(@fifo_url)

          @connection = Fog::Connection.new(
            @fifo_url,
            @persistent,
            @connection_options
          )
          authenticate
        end

        def authenticate
          response = @connection.request({
                                           :expects => [200, 204, 303],
                                           :host    => @fifo_uri.host,
                                           :method  => 'POST',
                                           :path    => create_path('sessions'),
                                           :headers => {
                                             "Content-Type" => "application/json",
                                             "Accept" => "application/json"
                                           },
                                           :body => Fog::JSON.encode({
                                                                       "user" => @fifo_username,
                                                                       "password" => @fifo_password
                                                                     })
                                         })

          @fifo_token = response.headers["x-snarl-token"] || File.basename(response.headers["location"])
        end

        def request(opts = {})
          opts[:headers] = {
            "X-Api-Version" => @fifo_version,
            "Content-Type" => "application/json",
            "Accept" => "application/json",
            "x-Snarl-Token" => @fifo_token
          }.merge(opts[:headers] || {})

          if opts[:body]
            opts[:body] = Fog::JSON.encode(opts[:body])
          end

          opts[:path] = create_path(opts[:path])
          response = @connection.request(opts)
          if response.headers["Content-Type"] == "application/json"
            response.body = json_decode(response.body)
          end

          #pp response
          response
        rescue Excon::Errors::HTTPStatusError => e
          raise_if_error!(e.request, e.response)
        end

        private

        def create_path(path)
          ::File.join(@fifo_uri.path, path)
        end

        def json_decode(body)
          parsed = Fog::JSON.decode(body)
          decode_time_attrs(parsed)
        end

        def decode_time_attrs(obj)
          if obj.kind_of?(Hash)
            obj["created"] = Time.parse(obj["created"]) unless obj["created"].nil? or obj["created"] == ''
            obj["updated"] = Time.parse(obj["updated"]) unless obj["updated"].nil? or obj["updated"] == ''
          elsif obj.kind_of?(Array)
            obj.map do |o|
              decode_time_attrs(o)
            end
          end

          obj
        end

        def raise_if_error!(request, response)
          case response.status
          when 401 then
            raise Fifo::Errors::Unauthorized.new('Invalid credentials were used', request, response)
          when 403 then
            raise Fifo::Errors::Forbidden.new('No permissions to the specified resource', request, response)
          when 404 then
            raise Fifo::Errors::NotFound.new('Requested resource was not found', request, response)
          when 405 then
            raise Fifo::Errors::MethodNotAllowed.new('Method not supported for the given resource', request, response)
          when 406 then
            raise Fifo::Errors::NotAcceptable.new('Try sending a different Accept header', request, response)
          when 409 then
            raise Fifo::Errors::Conflict.new('Most likely invalid or missing parameters', request, response)
          when 414 then
            raise Fifo::Errors::RequestEntityTooLarge.new('You sent too much data', request, response)
          when 415 then
            raise Fifo::Errors::UnsupportedMediaType.new('You encoded your request in a format we don\'t understand', request, response)
          when 420 then
            raise Fifo::Errors::PolicyNotForfilled.new('You are sending too many requests', request, response)
          when 449 then
            raise Fifo::Errors::RetryWith.new('Invalid API Version requested; try with a different API Version', request, response)
          when 503 then
            raise Fifo::Errors::ServiceUnavailable.new('Either there\'s no capacity in this datacenter, or we\'re in a maintenance window', request, response)
          end
        end

      end # Real
    end
  end
end
