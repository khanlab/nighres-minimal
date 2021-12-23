FROM continuumio/miniconda3:4.8.2

MAINTAINER alik@robarts.ca

#release 1.4.0 tag
ENV NIGHRES_TAG 6bce53ff20e50554afb5ed4e7c4d77cf3da0dfe9

RUN apt-get --allow-releaseinfo-change  update && mkdir -p /usr/share/man/man1  &&  apt-get install -y curl tree unzip bc default-jre  build-essential wget bzip2 ca-certificates  git  && \
apt --allow-releaseinfo-change  update && \
apt install -y openjdk-11-jdk && \
cd /tmp && wget https://files.pythonhosted.org/packages/97/c6/9249f9cc99404e782ce06b3a3710112c32783df59e9bd5ef94cd2771ccaa/JCC-3.10.tar.gz && \
tar -xvzf JCC-3.10.tar.gz

COPY setup.py /tmp/JCC-3.10
ENV PATH $PATH:/usr/lib/jvm/java-11-openjdk-amd64/bin
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/lib/jvm/java-11-openjdk-amd64/lib
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64/
ENV JCC_JDK /usr/lib/jvm/java-11-openjdk-amd64/

RUN cd /tmp/JCC-3.10 && python setup.py install && \
cd /opt && git clone http://github.com/nighres/nighres && cd /opt/nighres && git checkout ${NIGHRES_TAG} && ./build.sh && cd /opt/nighres && pip install . && \
rm -rf /opt/nighres /tmp/JCC-3.10 /tmp/JCC-3.10.tar.gz

ENV PATH /opt/conda/bin:$PATH
ENV _JAVA_OPTIONS=


