FROM avikdatta/basejupyterdockerimage

MAINTAINER reach4avik@yahoo.com

ENTRYPOINT []

ENV NB_USER vmuser

USER root
WORKDIR /root/

RUN apt-get -y update &&   \
    apt-get install --no-install-recommends -y   \
    tk-dev                 \
    gfortran               \
    sqlite3                \
    libhdf5-serial-dev     \
    libigraph0-dev         \
    &&  apt-get purge -y --auto-remove \
    &&  apt-get clean \
    &&  rm -rf /var/lib/apt/lists/*
    
USER $NB_USER
WORKDIR /home/$NB_USER

RUN rm -rf /home/$NB_USER/.pyenv

RUN  wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
     bash Miniconda3-latest-Linux-x86_64.sh -b
 
COPY environment.yaml /home/$NB_USER/environment.yaml

RUN conda env create -q --name notebook --file igf-pipelines/environment.yaml

RUN source activate notebook

EXPOSE 8888

CMD ["jupyter","lab","--ip=0.0.0.0","--port=8888","--no-browser","--NotebookApp.iopub_data_rate_limit=100000000"]
