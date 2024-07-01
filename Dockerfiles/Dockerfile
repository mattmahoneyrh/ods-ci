FROM docker.io/redhat/ubi9:latest
RUN dnf install python3.11 -y && \
    dnf install python3.11-pip -y && \
    dnf install python3.11-devel -y && \
    dnf install git -y && \
    dnf install gcc -y && \
    dnf install jq -y && \
    dnf install nano -y && \
    dnf install firefox -y && \
    pip3.11 install poetry distro && \
    git clone https://github.com/red-hat-data-services/ods-ci.git /ods-ci
COPY geckodriver-v0.34.0-linux64.tar.gz geckodriver-v0.34.0-linux64.tar.gz
RUN tar xvf geckodriver-v0.34.0-linux64.tar.gz
RUN mv geckodriver /usr/bin/
COPY oc-4.16.0-linux.tar.gz oc-4.16.0-linux.tar.gz
RUN tar xvf oc-4.16.0-linux.tar.gz oc-4.16.0-linux.tar.gz
RUN mv oc kubectl /usr/bin/
#COPY oc /usr/bin
#COPY test-variables.yml /ods-ci/ods_ci
WORKDIR /ods-ci
