# frozen_string_literal: true

module Steamworks
  class MicroTransaction
    def initialize(conn)
      @conn = conn

      @key = Steamworks::Configure.key
      @appid = Steamworks::Configure.appid
      @sandbox = Steamworks::Configure.sandbox
    end

    # https://partner.steamgames.com/doc/webapi/ISteamMicroTxn#GetUserInfo
    # GET https://partner.steam-api.com/ISteamMicroTxn/GetUserInfo/v2/
    def get_user_info(steam_id, ipaddress: nil)
      resp = @conn.get(endpoint("GetUserInfo/v2/")) do |req|
        req.params = {
          key: @key,
          appid: @appid,
          steamid: steam_id
        }
        req.params[:ipaddress] = ipaddress if ipaddress
      end

      resp.body
    end

    # https://partner.steamgames.com/doc/webapi/ISteamMicroTxn#InitTxn
    # POST https://partner.steam-api.com/ISteamMicroTxn/InitTxn/v3/
    def init_txn(order_id, steam_id, user_session: "web", options: {})
      resp = @conn.post(endpoint("InitTxn/v3/")) do |req|
        req.headers["Content-Type"] = "application/x-www-form-urlencoded"
        req.body =
          URI.encode_www_form({
            key: @key,
            appid: @appid,
            orderid: order_id,
            steamid: steam_id,
            usersession: user_session
          }.merge(options))
      end
      resp.body
    end

    # https://partner.steamgames.com/doc/webapi/ISteamMicroTxn#QueryTxn
    # GET https://partner.steam-api.com/ISteamMicroTxn/QueryTxn/v3/
    def query_txn(order_id, trans_id)
      resp = @conn.get(endpoint("QueryTxn/v3/")) do |req|
        req.params = {
          key: @key,
          appid: @appid,
          orderid: order_id,
          transid: trans_id
        }
      end

      resp.body
    end

    # https://partner.steamgames.com/doc/webapi/ISteamMicroTxn#GetReport
    # GET https://partner.steam-api.com/ISteamMicroTxn/GetReport/v5/
    def get_report(type, time, max_results: 1000)
      resp = @conn.get(endpoint("GetReport/v5/")) do |req|
        req.params = {
          key: @key,
          appid: @appid,
          type: type,
          time: Time.at(time).utc.iso8601, # RFC 3339 UTC formatted like: 2010-01-01T00:00:00Z
          max_results: max_results
        }
      end

      resp.body
    end

    private

    # MicroTxn API supports sandbox mode, which is used for testing.
    def endpoint(api_path)
      @sandbox ? "/ISteamMicroTxnSandbox/#{api_path}" : "/ISteamMicroTxn/#{api_path}"
    end
  end
end
