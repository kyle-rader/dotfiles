FROM ubuntu:16.04

RUN apt-get update \
  && apt-get upgrade \
  && apt-get -qq update \
  && apt-get -y install sudo wget \
  && useradd -m raderk \
  && echo "raderk:raderk" | chpasswd \
  && adduser raderk sudo

WORKDIR /home/raderk
USER raderk
CMD ["/bin/bash"]
