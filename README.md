# Atlassian Plugin SDK Dockerfile

[![Docker image build](https://github.com/toolsplus/atlassian-plugin-sdk/actions/workflows/docker-build.yml/badge.svg)](https://github.com/toolsplus/atlassian-plugin-sdk/actions/workflows/docker-build.yml)

This repository contains a **Dockerfile** for Atlassian Plugin SDK based on **openjdk:17-jdk-alpine**. This also includes the AWS CLI.

# Pull

```
docker pull ghcr.io/toolsplus/atlassian-plugin-sdk:latest
```

For more details refer to https://github.com/toolsplus/atlassian-plugin-sdk/pkgs/container/atlassian-plugin-sdk



# Release

To release a new image, simply create a new GitHub release with the name YYYYmmdd-n where n is the increasing number for any release made on the same day, e.g. 20220513-1, 20220513-2, 20220612-1, etc.

The GitHub release will trigger a workflow that builds and published a new Docker image to `ghcr.io/toolsplus/atlassian-plugin-sdk`.
