FROM elixir:1.9.1

RUN apt-get update && apt-get install -y inotify-tools

WORKDIR "/opt/app"

RUN mix local.hex --force && mix local.rebar --force

COPY config/* config/

COPY mix.exs mix.lock ./

CMD MIX_ENV=prod mix compile

RUN mix do deps.get, deps.compile

COPY . ./

EXPOSE 8080

CMD ["sh", "bin/start"]
