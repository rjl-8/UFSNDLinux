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
        # Note, run this step manually
        #DONE
        sudo apt-get update
        sudo apt-get upgrade

        #9 install git
        #DONE
        sudo apt-get install git
        git clone https://github.com/rjl-8/UFSNDLinux.git
        cd ~/UFSNDLinux
        rm ./linuxCourse
        # change permissions on pub file so it can be copied - temporary settings
        sudo chmod 777 linuxCourse.pub
        cp deploy.sh ~
        chmod a+x ~/deploy.sh
        cd ~
    elif [ $1 == 2 ]; then
        #2. change ssh port from 22 to 2200.
        #DONE
        #run script below to check /etc/ssh/sshd_config
        # and do whatever it says
        cd ~/UFSNDLinux
        chmod a+x chkssh.sh
        ./chkssh.sh

        #   Configure lightsail firewall to allow it
        #in aws console, select lightsail
        # then select the vertical elipsis for the instance in question
        # then select Manage
        # then select Networking
        # then add a Custom TCP opening for port 2200
        # then remove ssh tcp opening for port 22

        #   Configure ufw to only allow incoming connections for ssh (2200), http (80) and ntp (123)
        sudo ufw default deny incoming
        sudo ufw default allow outgoing
        #sudo ufw allow ssh
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
        #DONEzzzfailed
        sudo cp ~/UFSNDLinux/grader.sudo /etc/sudoers.d/grader.sudo
    elif [ $1 == 5 ]; then
        #5.	create ssh key pair for grader using ssh-keygen
        #DONE
        echo 'files created already via ssh-keygen'
        echo 'and stored in git project'
        echo 'just need to put them in the proper places'
        echo ''
        echo 'log in as grader and run step 5 again to copy them around'
        sudo mkdir /home/grader/.ssh
        sudo chown grader:grader /home/grader/.ssh
        sudo cp /home/ubuntu/UFSNDLinux/linuxCourse.pub /home/grader/.ssh/authorized_keys
        sudo chown grader:grader ~/.ssh/authorized_keys
        sudo chmod 700 /home/grader/.ssh
        sudo chmod 644 /home/grader/.ssh/authorized_keys
        echo 'Now can log in as grader with:'
        echo 'ssh grader@18.223.53.219 -p 2200 -i linuxCourse'
    fi
elif [ $USER == 'grader' ]; then
    if [ $1 == 5 ]; then
        #5 completion of ssh key pair setup
        #DONE
    if [ $1 == 6 ]; then
        #6.	make local timezone UTC
        #DONE
        echo 'make sure the following command shows "Etc/UTC"'
        cat /etc/timezone
        #if not
        #sudo vi /etc/timezone
    elif [ $1 == 7 ]; then
        #7.	install apache
        sudo apt-get install apache2
        # validate by sudo vi /var/www/html/index.html
        # and add something unique to the file
        # and then browse to the ip address and look for unique element

        #	Configure to serve python mod_wsgi
        sudo apt-get install libapache2-mod-wsgi
    elif [ $1 == 8 ]; then
        #8.	install postgresql
        sudo apt-get install postgresql
        #	Do not allow remote connections zzz
        #	Create a new database user named catalog that has limited permissions to your catalog application
        # wherever it prompts for a password, type "Passw0rd"
        sudo passwd postgres
        su postgres
        psql
        create role catalog with login password 'Passw0rd';
        create database catalog with owner=catalog;
        \q
        exit
    elif [ $1 == 9 ]; then
        #9.	install git
        #DONE above
    elif [ $1 == 10 ]; then
        #10 deploy the catalog project
        #   Note: When you set up OAuth for your application,
        #         you will need a DNS name that refers to your
        #         instance's IP address. You can use the
        #         xip.io service to get one; this is a public
        #         service offered for free by Basecamp. For
        #         instance, the DNS name 54.84.49.254.xip.io
        #         refers to the server above.
        git clone https://github.com/rjl-8/UFSNDCatalog.git

        #11 make the catalog project work when visiting the server.
        #   install python libraries like flask and sqlalchemy (and request)
        sudo apt install python-pip
        sudo pip install sqlalchemy
        #sudo pip install psycopg2
        sudo pip install psycopg2-binary
        sudo pip install flask
        sudo pip install oauth2client
        sudo pip install requests

        #cp files someplace
        sudo mkdir /var/www/wsgi/catalog
        #set ownership and permissions
        sudo cp -r ~/UFSNDCatalog/* /var/www/wsgi/catalog
        sudo python /var/www/wsgi/catalog/database_setup.py
        #sudo vi /var/www/wsgi/catalog/application.py
        #and hardcode the path for /var/www/wsgi/catalog/client_secrets.json
        sudo cp ~/UFSNDLinux/application.wsgi /var/www/wsgi/catalog/application.wsgi
        sudo cp ~/UFSNDLinux/catalog.conf /etc/apache2/sites-enabled/catalog.conf
        sudo apache2ctl restart
    elif [ $1 == 11 ]; then
    fi
else
    echo 'cannot do step $1 as user $USER'
fi
