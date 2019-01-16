#Static ip - 18.223.53.219
#

# Using user ubuntu
###################
if [ $USER == 'ubuntu' ]; then
#    if [ $1 == 0 ]; then
#        #0  setup for this deployment
#    fi

#    #validate that step 0 is complete first
#    if [ zzznot setup ]; then
#        echo 'run step 0 first as ubuntu'
#        return 0
#    fi

    if [ $1 == 1 ]; then
        #1. update all currently installed packages
        #DONE
        sudo apt-get update
        sudo apt-get upgrade
    elif [ $1 == 2 ]; then
        #2. change ssh port from 22 to 2200.
        #   Configure lightsail firewall to allow it
        #   Configure ufw to only allow incoming connections for ssh (2200), http (80) and ntp (123)
        sudo ufw default deny incoming
        sudo ufw default allow outgoing
        sudo ufw allow ssh
        sudo ufw allow 2200/tcp
        sudo ufw allow www
        sudo ufw allow ntp
        sudo ufw enable
    elif [ $1 == 3 ]; then
        #3.	create user named grader
        # copy grader related deploy files to grader folder
        sudo adduser grader
    elif [ $1 == 4 ]; then
        #4.	give grader sudo
        #DONE
        sudo echo 'grader ALL=(ALL:ALL) ALL' > /etc/sudoers.d/grader.sudo
    elif [ $1 == 5 ]; then
        #5.	create ssh key pair for grader using ssh-keygen
        echo 'do this step in git-bash locally'
        echo 'ssh-keygen'
        echo 'enter linuxCourse as a filename'
        echo 'log in as grader and run step 5 again'
    fi
elif [ $USER == 'grader' ]; then
    if [ $1 == 5 ]; then
        #5 completion of ssh key pair setup
        mkdir ~/.ssh
        touch ~/.ssh/authorized_keys
        echo 'vi authorized_keys and copy and paste the .pub key file contents'
        chmod 700 .ssh
        chmod 644 .ssh/authorized_keys
        echo 'Now can log in as grader with:'
        echo 'ssh grader@18.223.53.219 -p 2200 -i ~/.ssh/linuxCourse
    if [ $1 == 6 ]; then
        #6.	make local timezone UTC
        #DONE
        echo 'make sure the following command shows "Etc/UTC"'
        sudo echo 'Etc/UTC' > /etc/timezone
    elif [ $1 == 7 ]; then
        #7.	install apache
        #	Configure to serve python mod_wsgi
        #	If using python3 – sudo apt-get install libapache2-mod-wsgi-py3
    elif [ $1 == 8 ]; then
        #8.	install postgresql
        #	Do not allow remote connections
        #	Create a new database user named catalog that has limited permissions to your catalog application
    elif [ $1 == 9 ]; then
        #9.	install git
    elif [ $1 == 10 ]; then
        #10 deploy the catalog project
        #   install python libraries like flask and sqlalchemy (and request)
        #   Note: When you set up OAuth for your application, you will need a DNS name that refers to your instance's IP address. You can use the xip.io service to get one; this is a public service offered for free by Basecamp. For instance, the DNS name 54.84.49.254.xip.io refers to the server above.
    elif [ $1 == 11 ]; then
        #11 make the catalog project work when visiting the server.
        #   Make sure the .git folder is not publicly viewable – delete it
    fi
else
    echo 'cannot do step $1 as user $USER'
fi
