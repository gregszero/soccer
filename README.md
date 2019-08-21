# Soccer

Simple Rest and Protobuf API for soccer results

## Installation

[Install elixir](https://elixir-lang.org/install.html#distributions)

Install dependencies

 `$ mix local.hex`
 
 `$ mix.deps get`

## Running with Docker with load balancing

Init a docker Swarm

`$ docker swarm init`

Build an image 

`$ docker build .`

Deploy image to Swarm 

`$ docker stack deploy --compose-file=docker-compose.yml ex`

Check if services are up

`$ docker service ls`

Then try 


## Documentation

You can generate documentation running:

`$ mix docs`
