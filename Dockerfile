FROM amazonlinux:2

# Install dependencies
RUN yum update -y && \
    yum install -y git maven java-1.8.0-openjdk-devel postgresql-server httpd

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set up Apache
RUN echo "Hello World" > /var/www/html/index.html && \
    systemctl enable httpd

# Expose necessary ports
EXPOSE 80 5432

# Use the custom entrypoint script
ENTRYPOINT ["entrypoint.sh"]
