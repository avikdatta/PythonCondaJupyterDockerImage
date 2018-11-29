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

ENV PATH $PATH:/home/$NB_USER/miniconda3/bin/
RUN conda env create -q --name base --file /home/$NB_USER/environment.yaml

RUN echo ". /home/$NB_USER/miniconda3/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

EXPOSE 8888

USER root
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod a+x /tini
ENTRYPOINT [ "/tini", "--" ]
USER $NB_USER
CMD [ "jupyter","lab","--ip","0.0.0.0","--port","8888","--no-browser" ]
