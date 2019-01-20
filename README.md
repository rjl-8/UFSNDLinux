# UdacityFSNDFinal

This code is intended to satisfy the requirements of the final project in the Programming Fundamentals lesson of the Full Stack Web Developer nanodegree.

### Prerequisites

* Need access to an ssh application
* Need to configure the ssh application to use the linuxCourse key file
* Need an internet browser

## Built With

* [Python](http://python.org/) - The programming language used
* [Postgresql](http://postgresql.org) - The database used
* [AWS](https://aws.amazon.com) - the hosting service
* [Apache](http://www.apache.org/) - the webserver software
* [WSGI](https://wsgi.readthedocs.io/en/latest/) - Python hosting on Apache

## Built How

I scripted up the server setup process in the included deploy.sh script 
but step 1 needs to be run manually 
(mainly because it includes the step that retrieves the deploy.sh script)
* Step 1
```
# update initial apps
sudo apt-get update
sudo apt-get upgrade

# install git
sudo apt-get install git

# get this code and do some initial setup with the key files
# and deploy. script
git clone https://github.com/rjl-8/UFSNDLinux.git
cd ~/UFSNDLinux
rm ./linuxCourse
sudo chmod 777 linuxCourse.pub
cp deploy.sh ~
chmod a+x ~/deploy.sh
cd ~
```

The rest of the server setup steps are executed by the following commands:
logged in as ubuntu
```
cd ~
./deploy.sh 2a # needs manual action from the user
./deploy.sh 2b # needs manual action from the user
./deploy.sh 3  # interaction with the user
./deploy.sh 4
./deploy.sh 5
```
logged in as grader
```
cd ~
./deploy.sh 6  # needs manual action from the user
./deploy.sh 7  # interaction with the user
./deploy.sh 8  # interaction and needs manual action from the user
./deploy.sh 10
```

## Authors

* **Ron Lewis** - *Initial work* - [rjl-8](https://github.com/rjl-8)

## Usage

The server is located at ip 18.223.53.219
ssh into port 2200
The website is at 18.223.53.219/catalog

## Acknowledgments

* Hat tip to Udacity for forcing me to learn all this cool stuff