FROM ubuntu:16.04
MAINTAINER gcabico@kgi.edu

# Install prerequisites
RUN apt update && \
    apt-get install -y build-essential wget unzip python2.7 \
    python-dev git python-pip bats awscli curl \
    libcurl4-openssl-dev make gcc zlib1g-dev python3-pip \
    libbz2-dev

# Install liblzma development package
RUN apt-get install -y liblzma-dev

# Add the bucket command wrapper, used to run code via sciluigi
RUN pip3 install bucket_command_wrapper==0.2.0 

# Install BWA
RUN mkdir /usr/bwa && \
    cd /usr/bwa && \
    wget https://github.com/lh3/bwa/releases/download/v0.7.17/bwa-0.7.17.tar.bz2 && \
    tar xvjf bwa-0.7.17.tar.bz2 && \
    cd bwa-0.7.17 && \
    make && \
    cp bwa /usr/local/bin


# Install Samtools
RUN cd /usr/local/bin && \
    wget https://github.com/samtools/samtools/releases/download/1.7/samtools-1.7.tar.bz2 && \
    tar xvf samtools-1.7.tar.bz2 && \
    cd samtools-1.7 && \
    ./configure --without-curses --disable-lzma --disable-bz2 --prefix=/usr/local/bin && \
    make && \
    make install && \
    ln -s $PWD/samtools /usr/local/bin/

# Install BCFtools
RUN cd /usr/local/bin && \
    wget https://github.com/samtools/bcftools/releases/download/1.12/bcftools-1.12.tar.bz2 && \
    tar xvf bcftools-1.12.tar.bz2 && \
    cd bcftools-1.12 && \
    ./configure --prefix=/usr/local/bin && \
    make && \
    make install && \
    ln -s $PWD/bcftools /usr/local/bin/
