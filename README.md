#docker-wordpress

This blueprint installs [Wordpress](https://wordpress.org/) an open source blogging and content management system.

## Components
The stack comprises the following components (some are obtained through [dell/lamp-base](https://registry.hub.docker.com/u/dell/lamp-base)):

Name       | Version                 | Description
-----------|-------------------------|------------------------------
Wordpress  | 4                       | Content Management System
Ubuntu     | see [docker-lamp-base](https://github.com/dell-cloud-marketplace/docker-lamp-base)                  | Operating system
MySQL      | see [docker-lamp-base](https://github.com/dell-cloud-marketplace/docker-lamp-base) | Database
Apache     | see [docker-lamp-base](https://github.com/dell-cloud-marketplace/docker-lamp-base) | Web server
PHP        | see [docker-lamp-base](https://github.com/dell-cloud-marketplace/docker-lamp-base) | Scripting language

## Usage

### Start the Container
Start the container, as follows:


    docker run -d -p 80:80 -p 443:443 -p 3306:3306 --name wordpress dell/wordpress

You will have to check the container logs, in order to get the MySQL password:

    docker logs wordpress

You will see an output like the following:

    ====================================================================
    You can now connect to this MySQL Server using:

      mongo admin -u admin -pca1w7dUhnIgI --host <host> --port <port>

    Please remember to change the above password as soon as possible!
    MySQL user 'root' has no password but only allows local connections
    =====================================================================

In this case, **ca1w7dUhnIgI** is the password allocated to the admin user. Make a secure note of this value. You can use it later, to connect to MySQL (e.g. to backup data):

    mysql -u admin -pca1w7dUhnIgI -h127.0.0.1 -P3306

## Complete the installation

Open a web browser and navigate to either the public DNS or IP address of your instance. For example, if the IP address is 54.75.168.125, do:

    https://54.75.168.125

Your browser will warn you that the certificate is not trusted. If you are unclear about how to proceed, please consult your browser's documentation on how to accept the certificate.

You should see a page asking you to install WordPress. Select your language and click on Continue.

Next, supply the requested information for the following fields:

* Site Title
* Username
* Password
* Your E-mail

### Create Your Content
If you need assistance in using WordPress, there is huge amount of learning material avaliable online, for example:

* [The Online Manual](https://codex.wordpress.org/Main_Page)
* [59 Brilliant WordPress Tutorials](http://www.creativebloq.com/web-design/wordpress-tutorials-designers-1012990)
* [WordPressTutorials.com](http://www.wordpresstutorials.com)


### Image Details

Based on  [tutum/wordpress](https://github.com/tutumcloud/tutum-docker-wordpress)

Pre-built Image   | [https://registry.hub.docker.com/u/dell/wordpress](https://registry.hub.docker.com/u/dell/wordpress)
