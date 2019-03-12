[![DockerPulls](https://img.shields.io/docker/pulls/avikdatta/pythoncondajupyterdockerimage.svg)](https://registry.hub.docker.com/u/avikdatta/pythoncondajupyterdockerimage/)
[![DockerStars](https://img.shields.io/docker/stars/avikdatta/pythoncondajupyterdockerimage.svg)](https://registry.hub.docker.com/u/avikdatta/pythoncondajupyterdockerimage/)
[![DockerStars](https://img.shields.io/docker/automated/avikdatta/pythoncondajupyterdockerimage.svg)](https://registry.hub.docker.com/u/avikdatta/pythoncondajupyterdockerimage/)
[![](https://images.microbadger.com/badges/image/avikdatta/pythoncondajupyterdockerimage.svg)](https://microbadger.com/images/avikdatta/pythoncondajupyterdockerimage)
# PythonCondaJupyterDockerImage

Docker image for running jupyter notebook.

Run the jupyter lab using the following command

<pre><code>docker run -d \
  -p 8888:8888 \
  -v /path:/home/vmuser/path \
  avikdatta/pythoncondajupyterdockerimage bash -c "source ~/.bashrc && source activate pipeline-env && jupyter lab --ip=0.0.0.0 --port=8888 --no-browser"
</code></pre>