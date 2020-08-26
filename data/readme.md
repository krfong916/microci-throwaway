To create a volume

```sh
rm -r ./data
docker build -t micro_db .
docker run micro_db

```

In another terminal window

```sh
docker ps
docker cp [container id]:/var/lib/postgresql/data .
```
