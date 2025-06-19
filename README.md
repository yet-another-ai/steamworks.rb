# Steamworks

Steamworks Web API client for Ruby.

[Steam official documentation](https://partner.steamgames.com/doc/webapi)

## Supported APIs

- [ISteamUserAuth Interface](https://partner.steamgames.com/doc/webapi/ISteamUserAuth)
  - AuthenticateUserTicket

## Config
configuration is done through [anyway_config](https://github.com/palkan/anyway_config).

You can set the following environment variables:

```
STEAMWORKS_KEY=your_steamworks_key
STEAMWORKS_APPID=your_steamworks_app_id
STEAMWORKS_IDENTITY=your_steamworks_identity
```

## Example

```ruby
require "steamworks"

steamworks_api = Steamworks::API.new

steamworks_api.authenticate_user_ticket(ticket: params[:ticket]).to_json

```
