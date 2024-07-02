FROM docker.io/redhat/ubi9:latest
RUN dnf install python3.11 python3.11-pip python3.11-devel -y && \
    dnf install git gcc jq nano wget unzip -y && \
    pip3.11 install poetry distro
    #git clone git@gitlab.cee.redhat.com:ods/odhcluster.git /odhcluster && \
    #need to find a way to clone it, maybe it will be better to clone in the bootstrap machine and then \
    #just copy the whole repo inside the image
COPY ./* /ods-ci
RUN wget https://storage.googleapis.com/chrome-for-testing-public/126.0.6478.126/linux64/chromedriver-linux64.zip
RUN unzip chromedriver-linux64.zip
RUN cd chromedriver-linux64 && mv chromedriver /usr/bin/
RUN wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable-4.15/openshift-client-linux.tar.gz
RUN tar -xvf openshift-client-linux.tar.gz
RUN mv oc kubectl /usr/bin/
#COPY oc /usr/bin
#COPY test-variables.yml /ods-ci/ods_ci
