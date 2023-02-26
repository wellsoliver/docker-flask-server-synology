This is a dumb, simple example of running a Flask server in a poetry project on Synology NAS. I have a DS923+. I spent a few hours making this all work and figured I'd share this bootstrap version. I don't think my poetry stuff is quite up to snuff, so some improvements like a lock file etc may be appropriate. Still relatively new to docker so if anything in here can be streamlined I'm all ears.

Helpful Stack Overflow thread: https://stackoverflow.com/questions/72465421/how-to-use-poetry-with-docker

I have a Mac Studio which is ARM64, so this needs to be built for AMD64 to run on the NAS, using:

`docker build -t docker-flask-server . --platform=linux/amd64`

I saved the image to a gzip archive via:

`docker save docker-flask-server:latest | gzip > ~/Desktop/docker-flask-server.tgz`

And copy that to a mounted drive on the NAS.

`cp ~/Desktop/docker-flask-server.tgz /Volumes/...`

Then in the Docker app on Synology:

- Click Image
- Click Add -> Add From fIle
- Choose file from the shared folder you copied to, click Select
- Wait a bit!
- It should appear in the list of available images with Registry: Docker Hub.
- Click the image, select Launch
- Didn't change any of the options on the first page, click Next
- Didn't change any of the optinos on the second page, Next
- On third page, pick a local port you can use to forward to contaner port 5000, I used 8080, Next
- Nothing doing on Volume Settings, Next
- Take a gander at everything in the Summary page, make sure "Run this container after the wizard is finished" is checked, click Done
- Wait a bit!


Once ready, you should be able to click on Container and see it running. You should be able to open a browser and go to http://NAS_IP_HERE:8080 (or whatever port you picked) and see "Hello, Docker!"

You can also click on the container, click Details and see the logs including the HTTP requests, etc.

That's all.

I am sure my Dockerfile could be improved and my poetry setup a little more disciplined. Let me know.
