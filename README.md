#docker-wordpress

This blueprint installs [Wordpress](https://wordpress.org/) an open source blogging and content management system.

* [Components](#components)
* [Usage](#usage)
    * [Basic Example](#basic-example)
    * [Advanced Example 1](#advanced-example-1)   
    * [Advanced Example 2](#advanced-example-2)   
* [Administration](#administration)
    * [Connecting to MySQL](#connecting-to-mysql)
    * [Updating the Application](#updating-the-application)
    * [Connecting to MySQL from the Application](#connecting-to-mysql-from-the-application)
* [Reference](#reference)
    * [Image Details](#image-details)
    * [Dockerfile Settings](#dockerfile-settings)
    * [Port Details](#port-details)
    * [Volume Details](#volume-details)
    * [Additional Environmental Settings](#additional-environmental-settings)
* [Blueprint Details](#blueprint-details)
* [Building the Image](#building-the-image)
* [Issues](#issues)

<a name="components"></a>
## Components
The stack comprises the following components:

Name       | Version            | Description
-----------|--------------------|------------------------------
Ubuntu     | Trusty             | Operating system
Wordpress  | 4                  | Content Management System
MySQL      | refer to dell/lamp | Database
Apache     | refer to dell/lamp | Web server
PHP        | refer to dell/lamp | Scripting language

**If a component is an up-to-date, compatible version, as determined by the operating system package manager, at installation time, please complete the version information based on the install.**

<a name="usage"></a>
## Usage

<a name="basic-example"></a>
### Basic Example
Start your image binding host port 8080 to port 80 (Apache Web Server) in your container:

```no-highlight
docker run -d -p 80:80 -p 443:443 dell/wordpress
```

Test your deployment:

```no-highlight
curl http://localhost
```

<a name="administration"></a>
## Administration

<a name="connecting-to-mysql"></a>
### Connecting to MySQL
The first time that you run your container, a new user admin with all privileges will be created in MySQL with a random password. To get the password, check the logs of the container. You will see an output like the following:

```no-highlight
========================================================================
You can now connect to this MySQL Server using:

    mysql -uadmin -p47nnf4FweaKu -h<host> -P<port>

Please remember to change the above password as soon as possible!
MySQL user 'root' has no password but only allows local connections
========================================================================
```

In this case, **47nnf4FweaKu** is the password allocated to the admin user.

You can then connect to MySQL:

```no-highlight
mysql -uadmin -p47nnf4FweaKu
```

Note that the root user does not allow connections from outside the container. Please use this admin user instead.

<a name="updating-the-application"></a>
### Updating the Application
The PHP application files are available at path **/var/www/html** on the host. If you are not using a host volume, you will need to use [nsenter](http://jpetazzo.github.io/2014/03/23/lxc-attach-nsinit-nsenter-docker-0-9/) to attach to the container.

<a name="(#connecting-to-mysql-from-the-application)"></a>
### Connecting to MySQL from the Application
The bundled MySQL server has a `root` user with no password for local connections. Simply connect from your
PHP code with this user:

```php
<?php
$mysql = new mysqli("localhost", "root");
echo "MySQL Server info: ".$mysql->host_info;
?>
```

<a name="reference"></a>
## Reference

<a name="image-details"></a>
### Image Details

Attribute         | Value
------------------|------
Based on          | 
Github Repository | [https://github.com/ghostshark/docker-wordpress](https://github.com/ghostshark/docker-wordpress)
Pre-built Image   | [https://registry.hub.docker.com/u/dell/wordpress](registry.hub.docker.com/u/dell/wordpress)

<a name="dockerfile-settings"></a>
### Dockerfile Settings

Instruction | Value
------------|------
VOLUME      | ['/etc/mysql', '/var/lib/mysql']
EXPOSE      | ['80', '3306','443']
CMD         | ['/run.sh']

<a name="port-details"></a>
### Port Details

Port | Details
-----|--------
80   | Apache web server
3306 | MySQL admin
443  | SSL

<a name="volume-details"></a>
### Volume Details

Path           | Details
---------------|--------
/var/lib/mysql | MySQL data
/etc/mysql     | MySQL configuration

<a name="additional-environmental-settings"></a>
### Additional Environmental Settings

Variable   | Description
-----------|------------
MYSQL_PASS | The MySQL admin user password. If not specified, a random value will be generated.

<a name="blueprint-details"></a>
## Blueprint Details
Under construction.

<a name="building-the-image"></a>
## Building the Image
To build the image, execute the following command in the docker-wordpress folder:

```no-highlight
docker build -t dell/wordpress .
```

<a name="issues"></a>
## Issues

