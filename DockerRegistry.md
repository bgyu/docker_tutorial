# How to setup a private docker registry

## Set up the Docker Registry Server
To set up a private Docker registry, you'll need to create a Docker Registry Server. 
You can do this by running the following command on the server where you want to host the registry:
```bash
docker run -d -p 5000:5000 --restart=always --name registry registry:2
```
This command will start the Docker Registry Server and map port 5000 on the host to port 5000 in the container. 
The **--restart=always** flag ensures that the registry is started automatically whenever the server is rebooted.

## Push Docker images to the private registry
To push a Docker image to the private registry, you'll need to tag the image with the hostname and port of the registry, 
and then push the image to the registry:
```bash
docker build -t my-image .
docker tag my-image localhost:5000/my-image
docker push localhost:5000/my-image
```
This command will build a Docker image with the name my-image, tag it with the hostname and port of the registry (localhost:5000/my-image), 
and push it to the registry.

## Pull Docker images from the private registry
To pull a Docker image from the private registry, you'll need to specify the hostname and port of the registry when pulling the image:
```bash
docker pull localhost:5000/my-image
```
This command will pull the my-image image from the private registry located at localhost:5000.


# Configure authentication and authorization for a private Docker registry using the htpasswd utility and Nginx
## Install Nginx and htpasswd:
You'll need to install Nginx and htpasswd on the server where you're hosting the Docker registry. You can do this by running the following commands:
```bash
sudo apt-get update
sudo apt-get install nginx apache2-utils
```

## Create a password file:
Next, you'll need to create a password file using the htpasswd utility. 
This file will contain the usernames and passwords that are authorized to access the Docker registry. 
You can create the file by running the following command:
```bash
sudo htpasswd -c /etc/nginx/.htpasswd <username>
```

Replace **username** with the username you want to use to access the Docker registry. 
You'll be prompted to enter and confirm a password for the user.

## Configure Nginx

Next, you'll need to configure Nginx to proxy requests to the Docker registry and authenticate users using the password file. 
Create a new Nginx configuration file using the following command:
```bash
sudo nano /etc/nginx/conf.d/docker-registry.conf
```
Add the following configuration to the file:
```
upstream docker-registry {
  server registry:5000;
}

server {
  listen 443 ssl;
  server_name my-registry.com;

  ssl_certificate /path/to/ssl/cert.pem;
  ssl_certificate_key /path/to/ssl/key.pem;

  location / {
    auth_basic "Restricted";
    auth_basic_user_file /etc/nginx/.htpasswd;

    proxy_pass http://docker-registry;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

    add_header Docker-Distribution-Api-Version registry/2.0 always;
    add_header Www-Authenticate "Basic realm=\"Registry Realm\"";
  }
}
```
This configuration sets up Nginx to proxy requests to the Docker registry running on port 5000 and authenticate users 
using the password file located at /etc/nginx/.htpasswd. Replace my-registry.com with the hostname or IP address of your registry, 
and update the paths to the SSL certificate and key files.

## Restart Nginx
After configuring Nginx, you'll need to restart it for the changes to take effect. You can do this by running the following command:
```bash
sudo service nginx restart
```

## Test authentication and authorization
Now, when you try to pull or push Docker images to your private registry, 
you'll be prompted to enter the username and password that you configured earlier. 
For example, you can try pulling an image from the registry using the following command:

```bash
docker pull my-registry.com/my-image
```
You should be prompted to enter the username and password that you created earlier. 
Once you've authenticated, you should be able to pull or push images to the registry as usual.
