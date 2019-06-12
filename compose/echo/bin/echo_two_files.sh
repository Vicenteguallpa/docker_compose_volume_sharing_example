`The CONTAINER_VOLUME_LOCATION variable is taken from the Dockerfile ENV command not from the .env file`
echo "Hello World" > ${CONTAINER_VOLUME_LOCATION}/echo_file_1.txt
echo "It's nice to be back" > ${CONTAINER_VOLUME_LOCATION}/echo_file_2.txt
