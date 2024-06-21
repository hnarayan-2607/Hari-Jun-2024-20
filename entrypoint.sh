#!/bin/bash

# Start PostgreSQL
service postgresql start

# Start Apache
service httpd start

# Start VS Code
code --no-sandbox &

# Keep the container running
tail -f /dev/null
