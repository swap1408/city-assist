#!/usr/bin/env bash
set -euo pipefail

# Runtime injected environment variables
: "${VITE_API_URL:=/api}"

# Python API MUST be accessed through nginx, NOT python:8000
CITYASSIST_API_URL="/python-api"

# Generate env.js for frontend
cat > /usr/share/nginx/html/env.js <<EOF
window.__ENV__ = {
  VITE_API_URL: "${VITE_API_URL}",
  CITYASSIST_API_URL: "${CITYASSIST_API_URL}"
};
EOF

echo "Generated env.js:"
cat /usr/share/nginx/html/env.js

# Generate nginx config
envsubst '${BACKEND_URL}' \
  < /etc/nginx/templates/default.conf.template \
  > /etc/nginx/conf.d/default.conf

echo "Using BACKEND_URL='${BACKEND_URL}'"

exec nginx -g 'daemon off;'

