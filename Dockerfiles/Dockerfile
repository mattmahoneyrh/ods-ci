FROM docker.io/redhat/ubi9:latest
RUN dnf install python3.11 -y && \
    dnf install python3.11-pip -y && \
    dnf install python3.11-devel -y && \
    dnf install git -y && \
    dnf install gcc -y && \
    dnf install jq -y && \
    dnf install nano -y && \
    pip3.11 install poetry distro && \
    git clone https://github.com/red-hat-data-services/ods-ci.git /ods-ci
COPY oc /usr/bin
#COPY test-variables.yml /ods-ci/ods_ci
WORKDIR /ods-ci 
