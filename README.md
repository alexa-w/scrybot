# Scrybot

## Installation

### Requirements
- Erlang/OTP 21
- Elixir 1.8.1
- Administrator access to a Discord server
### Environment Variables

- You will need an environment variable DISCORD_TOKEN for Nostrum permissions

### Setup
- In order to get a token, go here https://discordapp.com/developers/applications/ and create a new application.
- The permissions you need should be 3072

## How to Run
- In the interactive shell: `iex -S mix`
- `mix run --no-halt`

## How to Use
- In any server this bot has permissions for, type `!card <card_name>`
- ex. `!card balduvian bears`
- A request will be sent to the Scryfall API for a fuzzy name search.
- If the query to Scryfall is successful, then the large image uri, the scryfall uri, name, and oracle text will be sent to the channel the message was sent to.