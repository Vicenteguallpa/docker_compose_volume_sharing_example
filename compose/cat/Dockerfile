FROM python:3

# Copy scripts from your local /bin to container /bin scripts
# Since cat_app context is set at ./compose/cat in docker-compose.yml,
# we only need /bin not /cat/bin or /compose/cat/bin
COPY /bin /bin

# Set variable for volume's location, make sure the location matches that in .env
ENV CONTAINER_VOLUME_LOCATION=/container_storage

# Set container volume location
VOLUME [${CONTAINER_VOLUME_LOCATION}]

# Set container work directory
WORKDIR ${CONTAINER_VOLUME_LOCATION}

# Command to run when we start container
CMD cat_two_files.sh
