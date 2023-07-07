# Steamworks

Steamworks Web API client for Ruby.

[Steam official documentation](https://partner.steamgames.com/doc/webapi)

## Supported APIs

- [ISteamUserAuth Interface](https://partner.steamgames.com/doc/webapi/ISteamUserAuth)
  - AuthenticateUserTicket

## Example

```ruby
require "steamworks"

class Steamworks::Configure
  set :key, "key"
  set :appid, "appid"
  set :identity, "identity"
end

steamworks_api = Steamworks::API.new

steamworks_api.authenticate_user_ticket(ticket: params[:ticket]).to_json

```
