# Devito

![](https://github.com/supersimple/devito/blob/main/devito-sm.png?raw=true)

An Elixir and PostgreSQL based url shortener.

## Interface

Devito is designed to be used with the [Devito CLI](https://github.com/supersimple/devito_cli/). Although you can also interface it using HTTP.

## Configuration

Authorization is handled via an API token. You must pass `auth_token=<VALUE>` with each request, and that token will be matched against the ENV VAR `AUTH_TOKEN`. The values cannot be set to `nil`.

Configure the application's short_code_chars to a list of values you want the short_code to be generated from.

`config :devito, short_code_chars: []`

## Endpoints

| Method | Path           | Description             | Required Params                                          | Optional Params |
| ------ | -------------- | ----------------------- | -------------------------------------------------------- | --------------- |
| GET    | /api/          | Index of all links      | auth_token=TOKEN                                         | download=true   |
| POST   | /api/link      | Create a new link       | auth_token=TOKEN; short_code=SHORTCODE; auth_token=TOKEN |
| GET    | /api/SHORTCODE | Shows info about a link | -                                                        | -               |
| POST   | /api/import    | imports JSON links      | auth_token=TOKEN; body=JSON                              | -               |

## Logo Credit

Devito Logo by [Mark Farris](https://markfarrisdesign.com)

## Running Locally

To start your Phoenix server:

- Setup the project with `mix setup`
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
