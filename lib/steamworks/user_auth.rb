# frozen_string_literal: true

module Steamworks
  class UserAuth
    def initialize(conn)
      @conn = conn

      @key = Steamworks::Configure.key
      @appid = Steamworks::Configure.appid
      @identity = Steamworks::Configure.identity
    end

    # https://partner.steamgames.com/doc/webapi/ISteamUserAuth#AuthenticateUserTicket
    # GET https://partner.steam-api.com/ISteamUserAuth/AuthenticateUserTicket/v1/
    def authenticate_user_ticket(ticket)
      resp = @conn.get("/ISteamUserAuth/AuthenticateUserTicket/v1/") do |req|
        req.params = {
          key: @key,
          appid: @appid,
          ticket: ticket,
          identity: @identity
        }
      end

      resp.body
    end
  end
end
