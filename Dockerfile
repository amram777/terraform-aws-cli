# Use a Debian-based image
# aws cli was not working because glibc was missing
# Switched from Alpine-based to a Debian-based image for better compatibility, as Debian includes glibc by default
FROM debian:bullseye

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
      curl \
      unzip \
      python3 \
      python3-pip \
      bash \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Download and install the latest Terraform
RUN curl -fsSL "https://releases.hashicorp.com/terraform/1.9.8/terraform_1.9.8_linux_amd64.zip" -o "terraform.zip" \
    && unzip terraform.zip -d /usr/local/bin \
    && rm terraform.zip

# Download and install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf awscliv2.zip aws

# Set default working directory
WORKDIR /app

# Entrypoint for convenience
ENTRYPOINT ["/bin/bash"]