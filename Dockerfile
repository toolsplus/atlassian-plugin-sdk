FROM openjdk:17-jdk-alpine

RUN apk add --no-cache curl tar bash procps

# Install custom Maven version because the on included in the Atlassian plugin SDK is not compatible with the SDK - doh!
# https://community.developer.atlassian.com/t/amps-8-3-1-build-failure/54483
ENV MAVEN_VERSION 3.8.5
ENV MAVEN_HOME /usr/lib/mvn
ENV PATH $MAVEN_HOME/bin:$PATH

RUN wget http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  tar -zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  rm apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  mv apache-maven-$MAVEN_VERSION /usr/lib/mvn

ARG ATLASSIAN_PLUGIN_SDK_VERSION=8.2.7
ARG BASE_URL=https://packages.atlassian.com/maven/repository/public/com/atlassian/amps/

# Configure ATLAS_MVN to ensure the SDK picks up the custom Maven version
# https://developer.atlassian.com/server/framework/atlassian-sdk/changing-the-default-maven-version/
ENV ATLAS_MVN $MAVEN_HOME/bin/mvn

RUN mkdir -p /usr/share/atlassian-plugin-sdk \
  && curl -fsSL -o /tmp/atlassian-plugin-sdk.tar.gz ${BASE_URL}/atlassian-plugin-sdk/${ATLASSIAN_PLUGIN_SDK_VERSION}/atlassian-plugin-sdk-${ATLASSIAN_PLUGIN_SDK_VERSION}.tar.gz \
  && tar -xzf /tmp/atlassian-plugin-sdk.tar.gz -C /usr/share \
  && rm -f /tmp/atlassian-plugin-sdk.tar.gz \
  && ln -s /usr/share/atlassian-plugin-sdk-${ATLASSIAN_PLUGIN_SDK_VERSION}/bin/* /usr/bin/

# Add node, yarn, aws-cli
RUN apk -v --update add nodejs yarn aws-cli \
    && rm /var/cache/apk/*

CMD atlas-version && aws --version && yarn --version && mvn --version
