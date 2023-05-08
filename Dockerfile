FROM centos:7
RUN yum -y install wget gcc make zlib-devel openssl-devel
RUN yum -y --enablerepo=extras install epel-release && yum -y update && yum clean all
RUN wget https://www.python.org/ftp/python/3.7.16/Python-3.7.16.tgz && tar xzf Python-3.7.16.tgz
RUN cd Python-3.7.16 && ./configure --enable-optimizations && make altinstall
RUN pip3.7 install pyperformance
RUN pyperformance venv create
RUN sed 's/default=loops/default=10/' -i /venv/cpython3.7-*/lib/python3.7/site-packages/pyperf/_runner.py
#CMD while true ; do pyperformance run --rigorous -o "py-$(date +%s).json"; done
#CMD for i in {1..3}; do pyperformance run --rigorous -o "/tmp/py-$(date +%s).json"; done; pause
CMD do pyperformance run --rigorous -o "/tmp/py-$(date +%s).json"; done; pause