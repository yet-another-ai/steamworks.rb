# Steamworks

Steamworks Web API client for Ruby.

[Steam official documentation](https://partner.steamgames.com/doc/webapi)

## Supported APIs

- [ISteamUserAuth Interface](https://partner.steamgames.com/doc/webapi/ISteamUserAuth)
  - AuthenticateUserTicket

## Example

```ruby
require 'steamworks'

api = Steamworks::API.new

api.configure do |config|
  config.key = "your_steam_web_api_key"
  config.appid = "your_steam_app_id"
  config.identity = "your_steam_identity"
end

puts api.authenticate_user_ticket(ticket: "ticket")

```
