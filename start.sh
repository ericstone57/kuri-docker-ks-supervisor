#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

supervisord -n -c /app/supervisor/supervisord.conf
