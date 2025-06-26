# frozen_string_literal: true

module Steamworks
  class SteamAPI
    attr_reader :user_auth, :micro_transaction

    def initialize
      @conn = Faraday.new("https://partner.steam-api.com") do |f|
        f.response :raise_error
        f.response :json
        f.headers["Accept"] = "application/json"
      end

      @user_auth = UserAuth.new(@conn)
      @micro_transaction = MicroTransaction.new(@conn)
    end
  end
end
