# frozen_string_literal: true

module Steamworks
  class Connection
    def initialize(gateway: :partner)
      raise ArgumentError, "Invalid gateway: #{gateway}" unless %i[partner public].include?(gateway)

      @connection = Faraday.new(
        url: gateway == :partner ? "https://partner.steam-api.com" : "https://api.steampowered.com",
        headers: { "Content-Type" => "application/x-www-form-urlencoded" }
      )
    end

    def get(path)
      @connection.get(path) do |req|
        yield(req) if block_given?
      end
    end

    def post(path)
      @connection.post(path) do |req|
        yield(req) if block_given?
      end
    end
  end
end
