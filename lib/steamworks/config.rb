# frozen_string_literal: true

module Steamworks
  class Config < Anyway::Config
    config_name :steamworks

    attr_config(
      key: "key",
      appid: "appid",
      identity: "identity"
    )
  end
end
