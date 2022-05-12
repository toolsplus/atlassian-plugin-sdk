FROM openjdk:8-jdk-alpine

RUN apk add --no-cache curl tar bash procps

ARG ATLASSIAN_PLUGIN_SDK_VERSION=8.2.7
ARG BASE_URL=https://packages.atlassian.com/maven/repository/public/com/atlassian/amps/

RUN mkdir -p /usr/share/atlassian-plugin-sdk \
  && curl -fsSL -o /tmp/atlassian-plugin-sdk.tar.gz ${BASE_URL}/atlassian-plugin-sdk/${ATLASSIAN_PLUGIN_SDK_VERSION}/atlassian-plugin-sdk-${ATLASSIAN_PLUGIN_SDK_VERSION}.tar.gz \
  && tar -xzf /tmp/atlassian-plugin-sdk.tar.gz -C /usr/share \
  && rm -f /tmp/atlassian-plugin-sdk.tar.gz \
  && ln -s /usr/share/atlassian-plugin-sdk-${ATLASSIAN_PLUGIN_SDK_VERSION}/bin/* /usr/bin/

# Add AWS CLI
ARG AWS_CLI_VERSION=1.19.112

RUN apk -v --update add python py-pip \
  && pip install --upgrade awscli==${AWS_CLI_VERSION} \
  && apk -v --purge del py-pip \
  && rm /var/cache/apk/*

# Add node and yarn
RUN apk -v --update add nodejs yarn \
    && rm /var/cache/apk/*

CMD atlas-version && aws --version && yarn --version
