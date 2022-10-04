# Flask_App
In this project I made a basic flask of a web server and wrapped it in a container in google cloud platform using terraform.
## Step 1:
I generated a container that runs a flask app.

first step I built and ran a container for the database using the following commands:

  docker build -t mydatabase
  
  docker run -d -p 5432:5432 mydatabase

second step I made that runs a random web server, that we can do REST calls to it in order to support queries from the database
therefore I used the following commands:

  docker build -t myserver
  
  docker run -d -p 5000:5000 myserver
  
  ## Step 2:
  Pushing the flask app to the cloud and running it on different virtual machines by generating managed instance group and VM compute instances in GCP, 
  I implemented the infrastructre via terraform, managing a multiple web servers together in managed instance group that can do auto-scaling from 1 machine to 10 machines
  in production enviroment.
 
 
