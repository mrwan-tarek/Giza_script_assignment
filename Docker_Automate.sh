#!/bin/bash
echo '----------------------------'
echo 'welcome to docker mini-system'
while :
do
  echo '----------------------------'
  echo '----------------------------'
  echo """
  1- stop an existed container
  2- start an existed container
  3- delete an existed container
  4- build an image from a Dockerfile
  5- create a new container 
  6- start a docker compose
  7- stop a docker compose
  8- exit
  """
  echo '----------------------------'
  read -p  'choose the service you need (1-8) : '  choice


  case "$choice" in
    1)
      echo '----------------------------'
      echo '----------------------------'
      echo "here all the running containers "
      docker ps --format '{{.Names}}'
      echo "enter the container name"
      read container_name    
  #stop container
      docker stop ${container_name} 2> error_stoping.txt
      if [ $? -eq 0 ]; then
        echo "The container stoped successfully."
      else
        echo "There was an error during stoping the container, check error_stoping.txt"
      fi   
      echo '----------------------------'
      echo '          done'
      echo '----------------------------'
      echo '----------------------------'     
     ;;
    2)
      echo '----------------------------'
      echo '----------------------------'
      echo "here all the non running containers "
      docker ps -a --filter "status=exited" --format '{{.Names}}'
      echo "enter the container name"
      read container_name    
  #stop container
      docker start ${container_name} 2> error_starting.txt
      if [ $? -eq 0 ]; then
        echo "The container started successfully."
      else
        echo "There was an error during starting the container, check error_starting.txt"
      fi   
      echo '----------------------------'
      echo '          done'
      echo '----------------------------'
      echo '----------------------------'     
     ;;
    3)
      echo '----------------------------'
      echo '----------------------------'
      echo "here all the containers in your system "
      docker ps -a --format '{{.Names}}'
      echo "enter the container name"
      read container_name    
  #stop container
      docker rm -f ${container_name} 2> error_deleting.txt
      if [ $? -eq 0 ]; then
        echo "The container deleted successfully."
      else
        echo "There was an error during deleting the container, check error_deleting.txt"
      fi   
      echo '----------------------------'
      echo '          done'
      echo '----------------------------'
      echo '----------------------------'     
     ;;

    4)
      echo '----------------------------'
      echo '----------------------------'
      echo "enter Dockerfile full path"
      read path
      echo "enter new image name"
      read image_name
  #bulid the image
      docker build -t ${image_name} ${path} 2> error_bulding.txt
      if [ $? -eq 0 ]; then
        echo "The image is built successfully."
      else
        echo "There was an error during bulding the image, check error_bulding.txt"
        exit
      fi
      echo '----------------------------'
      echo '          done'
      echo '----------------------------'
      echo '----------------------------'
    ;;

    5)
      echo '----------------------------'
      echo '----------------------------'
      echo "enter image name"
      read image_name
      echo "enter container name"
      read container_name
      echo "enter any additional options you need like ports or volumes"
      read options
  #run the container
      docker run -d ${options} --name ${container_name} ${image_name} 2> error_running.txt
      if [ $? -eq 0 ]; then
        echo "The container created and run successfully."
      else
        echo "There was an error during creating the container, check error_running.txt"
      fi
      echo '----------------------------'
      echo '          done'
      echo '----------------------------'
      echo '----------------------------'
      ;;
    6)
      echo '----------------------------'
      echo '----------------------------'
      echo "enter compose file full path"
      read path
  #start the compose
      cd ${path}
      docker compose up -d 2> error_starting_compose.txt
      if [ $? -eq 0 ]; then
        echo "The compose is started successfully."
      else
        echo "There was an error during starting the compose, check error_starting_compose.txt"
        exit
      fi
      echo '----------------------------'
      echo '          done'
      echo '----------------------------'
      echo '----------------------------'
     ;;

    7)
      echo '----------------------------'
      echo '----------------------------'
      echo "enter compose file full path"
      read path
  #stop the compose
      cd ${path}
      docker compose down 2> error_stoping_compose.txt
      if [ $? -eq 0 ]; then
        echo "The compose is stoped successfully."
      else
        echo "There was an error during stoping the compose, check error_stoping_compose.txt"
        exit
      fi
      echo '----------------------------'
      echo '          done'
      echo '----------------------------'
      echo '----------------------------'  
     ;;
    8)
      exit
      ;;
    *)
      continue
      ;;
  esac
  read -p  'want to do another service (y/n) : '  loop
  while [[ $loop != 'y' && $loop != 'n' ]] 2> /dev/null;
  do
    read -p  'choose a correct choice (y/n) : '  loop
    if [[ $loop == 'y' || $loop == 'n' ]] 2> /dev/null; then
        break
    else
        continue
    fi
  done
  if [ $loop == 'y' ] 2> /dev/null; then
        continue
  elif [ $loop == 'n' ] 2> /dev/null; then
        break
  fi



done