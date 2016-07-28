#!/bin/bash

# Collects log files from Dockers
/root/copy_docker_files.sh
/root/make_backup.sh

# Send file to S3
/usr/bin/env python /root/log_file_upload.py AKIAINMJVDBAUCL6fake eLh3anx+uqiHGw/KHgYJsFKlGLA4JTui+3GUfake
/usr/bin/env python /root/bkp_file_upload.py AKIAINMJVDBAUCL6fake eLh3anx+uqiHGw/KHgYJsFKlGLA4JTui+3GUfake
