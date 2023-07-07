# frozen_string_literal: true

module Steamworks
  class API
    def initialize
      @partner_conn = Steamworks::Connection.new(gateway: :partner)
      @public_conn = Steamworks::Connection.new(gateway: :public)

      config = Steamworks::Configure
      @key = config.key
      @appid = config.appid
      @identity = config.identity
    end

    # https://partner.steamgames.com/doc/webapi/ISteamUserAuth#AuthenticateUserTicket
    # GET https://partner.steam-api.com/ISteamUserAuth/AuthenticateUserTicket/v1/
    # key: string
    # appid: uint32
    # ticket: string
    # identity: string
    def authenticate_user_ticket(ticket: nil)
      resp = @partner_conn.get("/ISteamUserAuth/AuthenticateUserTicket/v1/") do |req|
        req.params = {
          key: @key,
          appid: @appid,
          ticket: ticket,
          identity: @identity
        }
      end

      JSON.parse(resp.body)
    end
  end
end
