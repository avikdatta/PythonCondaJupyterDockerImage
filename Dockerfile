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
    npm nodejs-legacy      \
    default-jre             \
    &&  apt-get purge -y --auto-remove \
    &&  apt-get clean \
    &&  rm -rf /var/lib/apt/lists/*
    
USER $NB_USER
WORKDIR /home/$NB_USER

RUN rm -rf /home/$NB_USER/.pyenv

#RUN  wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
#     bash Miniconda3-latest-Linux-x86_64.sh -b
 
COPY environment.yaml /home/$NB_USER/environment.yaml

ENV PATH $PATH:/home/$NB_USER/miniconda3/bin/
RUN conda env create -q --file /home/$NB_USER/environment.yaml

RUN echo "conda deactivate" >> ~/.bashrc && \
    echo "conda activate pipeline-env" >> ~/.bashrc

USER root
#RUN npm install -g configurable-http-proxy && \
#    rm -rf /root/.cache && \
#    rm -rf /home/${NB_USER}/tmp


ENV TINI_VERSION v0.18.0
RUN wget --quiet  https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini && \
    mv tini /usr/local/bin/tini && \ 
    chmod +x /usr/local/bin/tini

#RUN /home/$NB_USER/miniconda3/envs/pipeline-env/bin/jupyter nbextension enable --py --sys-prefix widgetsnbextension


USER $NB_USER
EXPOSE 8888


ENTRYPOINT ["/usr/local/bin/tini", "--"]
CMD [ "/bin/bash" ]
