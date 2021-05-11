#!/bin/bash

IMAGE="xops-awscli:latest"
LOCAL_REPO="/path to my local folder"
WORK_DIR="/container_working_dir"


docker run -it --volume="$LOCAL_REPO":"$WORK_DIR" --workdir="$WORK_DIR" --entrypoint=/bin/bash "$IMAGE"

