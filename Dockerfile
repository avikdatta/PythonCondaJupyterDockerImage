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
RUN conda env create -q --name notebook --file /home/$NB_USER/environment.yaml

RUN echo ". /home/$NB_USER/miniconda3/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate notebook" >> ~/.bashrc && \
    . /home/$NB_USER/.bashrc

EXPOSE 8888

COPY run_jupyter.sh /home/$NB_USER/run_jupyter.sh

USER root
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod a+x /tini
ENTRYPOINT [ "/tini", "--" ]
USER $NB_USER
CMD ["bash","/home/$NB_USER/run_jupyter.sh"]
