FROM fedora:21

# install needed packages

RUN yum install -y rpm-ostree git polipo; \
yum clean all

# create working dir, clone fedora and centos atomic definitions

RUN mkdir -p /home/working; \
cd /home/working; \
git clone https://github.com/CentOS/sig-atomic-buildscripts; \
git clone https://git.fedorahosted.org/git/fedora-atomic.git; \

# create and initialize repo directory

mkdir -p /srv/rpm-ostree/repo && \
cd /srv/rpm-ostree/ && \
ostree --repo=repo init --mode=archive-z2

# expose default SimpleHTTPServer port, set working dir

EXPOSE 8000
WORKDIR /home/working

# start web proxy and SimpleHTTPServer

CMD polipo; pushd /srv/rpm-ostree/repo; python -m SimpleHTTPServer; popd

