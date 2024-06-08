#FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04
#FROM nvidia/cuda:12.5.0-devel-ubuntu22.04

RUN apt update -y
RUN apt install -y wget

RUN apt install -y build-essential
RUN apt install -y python3 python3-pip python-is-python3

## Miniconda
RUN mkdir -p /miniconda3
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /miniconda3/miniconda.sh
RUN bash /miniconda3/miniconda.sh -b -u -p /miniconda3
RUN /miniconda3/bin/conda init bash


WORKDIR /root/gaussian-splatting
COPY environment.yml /root/gaussian-splatting/environment.yml
COPY submodules /root/gaussian-splatting/submodules
RUN /miniconda3/bin/conda env create -f environment.yml
# conda env createがが終わったら不要
RUN rm -rf /root/gaussian-splatting 

RUN apt-get install -y git

CMD ["/bin/bash"]