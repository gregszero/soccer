# Soccer

Simple Rest and Protobuf API for soccer results

## Installation

[Install elixir](https://elixir-lang.org/install.html#distributions)

Install dependencies

 `$ mix local.hex`
 
 `$ mix.deps get`

## Application Documentation

You can generate documentation running:

`$ mix docs`

## API Documentation

Import the file `swagger.yml` to [Swagger Editor](https://editor.swagger.io/)

## Benchmarking

To generate benchmarking results, run:

`$ mix run test/benchmarking/soccer_benchmark.ex`

## Running with Docker with load balancing

Init a docker Swarm

`$ docker swarm init`

Build an image 

`$ docker build .`

Deploy image to Swarm 

`$ docker stack deploy --compose-file=docker-compose.yml ex`

Check if services are up

`$ docker service ls`

DONE!
