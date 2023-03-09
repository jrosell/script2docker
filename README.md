# script2docker

In this repo you can see a reproducible example of how to run one script that genrates plot data and plot visualization in an output folder.

```
docker build -t script2docker/myplot .
```

```
docker run -it --rm -v `pwd`/data:/data -v `pwd`/output:/output script2docker/myplot
```
