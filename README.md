# docker_compose_volume_sharing_example

Open a terminal and create a directory for your project as follows: 
```
$ mkdir docker_compose_volume_sharing_example
```
cd into *docker_compose_volume_sharing_example* and create two directories, *compose* and *local_storage*, as follows:
```
$ mkdir compose
$ mkdir local_storage
```
Your project structure should look like the following:
```
/docker_compose_volume_sharing_example
  /compose
  /local_storage
    
```
cd into *local_storage* and create a file, my_file.txt, as follows:
```
$ touch my_file.txt
```
Use a text editor to add text to my_file.txt. In this example my_file.txt contains the following:
```
Hello docker compose!
```
cd into *compose* and create two directories, *cat* and *echo* , as follows:
```
$ mkdir cat
$ mkdir echo
```
Your project structure should now look like the following:
```
/docker_compose_volume_sharing_example
  /compose
    /cat
    /echo
  /local_storage
    my_file.txt
```
cd into *cat* and create a directory, *bin*, as follows:
```
$ mkdir bin
```
cd into *bin* and create a new shell script, cat_two_files.sh, as follows:
```
$ touch cat_two_files.sh
```
Use a shell script editor to add the following to cat_two_files.sh:
```
cat ${CONTAINER_VOLUME_LOCATION}/echo_file_1.txt
cat ${CONTAINER_VOLUME_LOCATION}/echo_file_2.txt
cat ${CONTAINER_VOLUME_LOCATION}/my_file.txt
```
cd into *cat* and create a file, Dockerfile, as follows:
```
$ touch Dockerfile
```
Your project structure should now look like the following:
```
/docker_compose_volume_sharing_example
  /compose
    /cat
      /bin
        cat_two_files.sh
      Dockerfile
    /echo
  /local_storage
    my_file.txt
```
Use a text editor to add the following to Dockerfile:
```
FROM python:3
COPY /bin /bin
ENV CONTAINER_VOLUME_LOCATION=/container_storage
VOLUME [${CONTAINER_VOLUME_LOCATION}]
WORKDIR ${CONTAINER_VOLUME_LOCATION}
CMD cat_two_files.sh
```
cd into *echo* and create a new directory, *bin*, as follows:
```
$ mkdir bin
```
cd into *echo/bin* and create a new shell script, *echo_two_files.sh*, as follows:
```
$ touch echo_two_files.sh
```
Use a shell script editor to add the following to echo_two_files.sh:
```
echo "Hello World" > ${CONTAINER_VOLUME_LOCATION}/echo_file_1.txt
echo "It's nice to be back" > ${CONTAINER_VOLUME_LOCATION}/echo_file_2.txt
```
cd into *echo* and create a file, Dockerfile, as follows:
```
$ touch Dockerfile
```
Your project structure should now look like the following:
```
/docker_compose_volume_sharing_example
  /compose
    /cat
      /bin
        cat_two_files.sh
      Dockerfile
    /echo
      /bin
        echo_two_files.sh
      Dockerfile
  /local_storage
    my_file.txt
```
Use a text editor to add the following to echo/Dockerfile:
```
FROM python:3
COPY /bin /bin
ENV CONTAINER_VOLUME_LOCATION=/container_storage
VOLUME [${CONTAINER_VOLUME_LOCATION}]
WORKDIR ${CONTAINER_VOLUME_LOCATION}
CMD echo_two_files.sh
```
cd into *docker_compose_volume_sharing_example* and create a new file, .env, as follows:
```
$ touch .env
```
Use a text editor to add the following to .env:
```
LOCAL_VOLUME_LOCATION=./local_storage
CONTAINER_VOLUME_LOCATION=/container_storage
```
Now, within *docker_compose_volume_sharing_example*, create a new yaml file, docker-compose.yml, as follows:
```
touch docker-compose.yml
```
Use a text editor to add the following to docker-compose.yml:
```
version: "3.3"

services:
  echo_app:
    build:
      context: ./compose/echo
    volumes:
      - ${LOCAL_VOLUME_LOCATION}:${CONTAINER_VOLUME_LOCATION}

  cat_app:
    build:
      context: ./compose/cat
    volumes:
      - ${LOCAL_VOLUME_LOCATION}:${CONTAINER_VOLUME_LOCATION}
    depends_on:
      - echo_app
```
Your project directory should now look like:
```
/docker_compose_volume_sharing_example
  /compose
    /cat
      /bin
        cat_two_files.sh
      Dockerfile
    /echo
      /bin
        echo_two_files.sh
      Dockerfile
  /local_storage
    my_file.txt
  .env
  docker-compose.yml
```
Now, within *docker_compose_volume_sharing_example*, run the following command:
```
$ docker-compose build
```
You should see an output similar to the following:
```
Building echo_app
Step 1/6 : FROM python:3
 ---> 34a518642c76
Step 2/6 : COPY /bin /bin
 ---> Using cache
 ---> eb7c23189f9d
Step 3/6 : ENV CONTAINER_VOLUME_LOCATION=/container_storage
 ---> Using cache
 ---> 9ff7941ac7b5
Step 4/6 : VOLUME [${CONTAINER_VOLUME_LOCATION}]
 ---> Using cache
 ---> 403f2447b0b5
Step 5/6 : WORKDIR ${CONTAINER_VOLUME_LOCATION}
 ---> Using cache
 ---> d4df0dcffc58
Step 6/6 : CMD echo_two_files.sh
 ---> Using cache
 ---> 4056e377e002

Successfully built 4056e377e002
Successfully tagged dockercomposevolumesharingexample_echo_app:latest
Building cat_app
Step 1/6 : FROM python:3
 ---> 34a518642c76
Step 2/6 : COPY /bin /bin
 ---> Using cache
 ---> 6957fff7e7fe
Step 3/6 : ENV CONTAINER_VOLUME_LOCATION=/container_storage
 ---> Using cache
 ---> 0afc9e68924c
Step 4/6 : VOLUME [${CONTAINER_VOLUME_LOCATION}]
 ---> Using cache
 ---> bfb6e5bc0050
Step 5/6 : WORKDIR ${CONTAINER_VOLUME_LOCATION}
 ---> Using cache
 ---> 78f81e994810
Step 6/6 : CMD cat_two_files.sh
 ---> Using cache
 ---> 26ca6e36c1e8

Successfully built 26ca6e36c1e8
Successfully tagged dockercomposevolumesharingexample_cat_app:latest
```
Now run thw following command:
```
$ docker-compose up
```
You should see an output similar to the following:
```
TODO
```
Inside *local_storage* you should now see two new text files, echo_file_1.txt and echo_file_2.txt with respecitve content:
```
Hello World
```
```
It's nice to be back
```
Your project directory should now look like:
```
/docker_compose_volume_sharing_example
  /compose
    /cat
      /bin
        cat_two_files.sh
      Dockerfile
    /echo
      /bin
        echo_two_files.sh
      Dockerfile
  /local_storage
    echo_file_1.txt
    echo_file_2.txt
    my_file.txt
  .env
  docker-compose.yml
```
Congrats! You have successfully completed container volume communication!
