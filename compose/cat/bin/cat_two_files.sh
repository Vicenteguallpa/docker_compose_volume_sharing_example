`The CONTAINER_VOLUME_LOCATION variable is taken from the Dockerfile ENV command not the .env file`
cat ${CONTAINER_VOLUME_LOCATION}/echo_file_1.txt
cat ${CONTAINER_VOLUME_LOCATION}/echo_file_2.txt
cat ${CONTAINER_VOLUME_LOCATION}/my_file.txt
