#docker-wordpress

This image installs [Wordpress](https://wordpress.org/) an open source blogging and content management system.

## Components
The stack comprises the following components (some are obtained through [dell/lamp-base](https://github.com/dell-cloud-marketplace/docker-lamp-base)):

Name       | Version                 | Description
-----------|-------------------------|------------------------------
Wordpress  | 4.1                     | Content Management System
Ubuntu     | see [docker-lamp-base](https://github.com/dell-cloud-marketplace/docker-lamp-base)                  | Operating system
MySQL      | see [docker-lamp-base](https://github.com/dell-cloud-marketplace/docker-lamp-base) | Database
Apache     | see [docker-lamp-base](https://github.com/dell-cloud-marketplace/docker-lamp-base) | Web server
PHP        | see [docker-lamp-base](https://github.com/dell-cloud-marketplace/docker-lamp-base) | Scripting language

## Usage

### 1. Start the Container
If you wish to create data volumes, which will survive a restart or recreation of the container, please follow the instructions in [Advanced Usage](#advanced-usage).

#### A. Basic Usage
Start your container with:

 - Ports 80, 443 (Apache Web Server) and 3306 (MySQL) exposed
 - A named container (**wordpress**)

 As follows:

```no-highlight
sudo docker run -d -p 80:80 -p 443:443 -p 3306:3306 --name wordpress dell/wordpress
```

<a name="advanced-usage"></a>
#### B. Advanced Usage
Start your container with:

* Ports 80, 443 (Apache Web Server) and 3306 (MySQL) exposed
* A named container (**wordpress**)
* A predefined password for the MySQL **admin** user
* Two data volumes (which will survive a restart or recreation of the container). The MySQL data is available in **/data/mysql** on the host. The PHP application files are available in **/app** on the host.

As follows:

```no-highlight
sudo docker run -d \
    -p 80:80 \
    -p 443:443 \
    -p 3306:3306 \
    -v /app:/var/www/html \
    -v /data/mysql:/var/lib/mysql \
    -e MYSQL_PASS="password"  \
    --name wordpress \
    dell/wordpress
```

### 2. Check the Log Files

If you haven't defined a MySQL password, the container will generate a random one. Check the logs for the password by running: 

```no-highlight
sudo docker logs wordpress
```

You will see output like the following:

```no-highlight
========================================================================
You can now connect to this MySQL Server using:

   mysql admin -u admin -pca1w7dUhnIgI --host <host>  -h<host> -P<port>

   Please remember to change the above password as soon as possible!
   MySQL user 'root' has no password but only allows local connections
========================================================================
```

In this case, **ca1w7dUhnIgI** is the password allocated to the admin user. Make a secure note of this value. You can use it later, to connect to MySQL (e.g. to backup data):

```no-highlight
mysql -u admin -pca1w7dUhnIgI -h127.0.0.1 -P3306
```

## Complete the Installation

Open a web browser and navigate to either the public DNS or IP address of your instance. For example, if the IP address is 54.75.168.125, do:

```no-highlight
https://54.75.168.125
```

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

## Reference

### Image Details

Based on  [tutum/wordpress](https://github.com/tutumcloud/tutum-docker-wordpress)

Pre-built Image   | [https://registry.hub.docker.com/u/dell/wordpress](https://registry.hub.docker.com/u/dell/wordpress)
