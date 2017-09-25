Pentaho - Rapid Deployment with Docker 
=====================

##Pentaho
[Pentaho](http://www.pentaho.com/) addresses the barriers that block your organization's ability to get value from all your data.  The platform simplifies preparing and blending any data and includes a spectrum of tools to easily analyze, visualize, explore, report and predict. Open, embeddable and extensible, Pentaho is architected to ensure that each member of your team -- from developers to business users -- can easily translate data into value. 

##Docker
[Docker](http://www.docker.com/) is an open platform for developers and sysadmins to build, ship, and run distributed applications. Consisting of Docker Engine, a portable, lightweight runtime and packaging tool, and Docker Hub, a cloud service for sharing applications and automating workflows, Docker enables apps to be quickly assembled from components and eliminates the friction between development, QA, and production environments. As a result, IT can ship faster and run the same app, unchanged, on laptops, data center VMs, and any cloud.

##Docker Compose
[Docker-compose](https://docs.docker.com/compose/) is a tool for defining and running multi-container Docker applications.

##Running Pentaho
###Clone and edit Dockerfile template

<pre>
sudo git clone https://github.com/firespring/pentaho-server.git
cd pentaho-server
docker-compose up
</pre>


This will bring up a postgres 9.6 container and a Pentaho 7.1 container. The container ships with a dummy, self-signed certificate for the https connection.
