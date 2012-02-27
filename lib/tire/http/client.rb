module Tire

  module HTTP

    module Client

      class RestClient
        ConnectionExceptions = [::RestClient::ServerBrokeConnection, ::RestClient::RequestTimeout]

        def self.get(url, data=nil)
          perform ::RestClient::Request.new(:method => :get, :url => url, :payload => data, :headers => self.get_header).execute
        rescue *ConnectionExceptions
          raise
        rescue ::RestClient::Exception => e
          Response.new e.http_body, e.http_code
        end

        def self.post(url, data)
          perform ::RestClient.post(url, data, self,get_header)
        rescue *ConnectionExceptions
          raise
        rescue ::RestClient::Exception => e
          Response.new e.http_body, e.http_code
        end

        def self.put(url, data)
          perform ::RestClient.put(url, data, self,get_header)
        rescue *ConnectionExceptions
          raise
        rescue ::RestClient::Exception => e
          Response.new e.http_body, e.http_code
        end

        def self.delete(url)
          perform ::RestClient.delete(url, self,get_header)
        rescue *ConnectionExceptions
          raise
        rescue ::RestClient::Exception => e
          Response.new e.http_body, e.http_code
        end

        def self.head(url)
          perform ::RestClient.head(url, self,get_header)
        rescue *ConnectionExceptions
          raise
        rescue ::RestClient::Exception => e
          Response.new e.http_body, e.http_code
        end

        private

        def self.perform(response)
          Response.new response.body, response.code, response.headers
        end

        def self.get_header
          Rails.logger.debug { " get header "} 
          Rails.logger.debug { { 'TOKEN' => Tire::Configuration.token } } 
          { 'TOKEN' => Tire::Configuration.token } 
        end 

      end

    end

  end

end
