docker-wordpress
================

Out-of-the-box Wordpress docker image


Usage
-----

To create the image `dell/wordpress`, execute the following command on the dell-docker-wordpress folder:

    docker build -t dell/wordpress .

You can now push your new image to the registry:

    docker push dell/wordpress


Running your Wordpress docker image
-----------------------------------

Start your image:

    docker run -d -p 80:80 dell/wordpress

Test your deployment:

    curl http://localhost/

You can now start configuring your Wordpress container!


More information
----------------

For details on how to access the bundled MySQL Server, set specific passwords or disable .htaccess,
please visit the [dell/lamp repository on github](https://github.com/ghostshark/dell-docker-lamp)
