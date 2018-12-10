FROM openjdk:8-jdk

ARG SDK_VERSION=6.3.12
ARG BASE_URL=https://packages.atlassian.com/maven/repository/public/com/atlassian/amps/

RUN mkdir -p /usr/share/atlassian-plugin-sdk \
  && curl -fsSL -o /tmp/atlassian-plugin-sdk.tar.gz ${BASE_URL}/atlassian-plugin-sdk/${SDK_VERSION}/atlassian-plugin-sdk-${SDK_VERSION}.tar.gz \
  && tar -xzf /tmp/atlassian-plugin-sdk.tar.gz -C /usr/share \
  && rm -f /tmp/atlassian-plugin-sdk.tar.gz \
  && ln -s /usr/share/atlassian-plugin-sdk-${SDK_VERSION}/bin/* /usr/bin/

# Add AWS CLI
ARG AWS_CLI_VERSION=1.16.60

RUN apt-get update \
  && apt-get install -y python python-pip \
  && pip install --upgrade awscli==${AWS_CLI_VERSION} \
  && apt-get --purge -y remove python-pip

CMD atlas-version && aws --version