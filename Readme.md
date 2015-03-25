# Examples how to use SimplerTiles

SimplerTiles is a ruby wrapper for SimpleTiles a simple tile server from propublica

# Usage

## Docker
```
docker-compose build
docker-compose up
```

You will habe two servers. One running on ``3332`` and the other on ``3331``

## locally
if you have ruby installed just use the following to start the first server
```
bundle install
puma
```

and the other server (the simple version)
```
bundle install
puma simple.ru
```

Both servers run on localhost:9292

