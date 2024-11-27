# Use a lightweight base image with Terraform
FROM hashicorp/terraform:latest

# Install dependencies
RUN apk add --no-cache \
      python3 \
      bash \
      curl \
      unzip

# Download and install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf awscliv2.zip aws

# Set default working directory
WORKDIR /app

# Entrypoint for convenience
ENTRYPOINT ["/bin/bash"]