### Generate docker image
```
$ make gz7_kinetic
```

### Run docker image
```
./run_docker.sh -d gz7_kinetic
```

### TODO

- Create another Dockerfile with the name `nvidia` and set the flag `--runtime=nvidia` when launching.
