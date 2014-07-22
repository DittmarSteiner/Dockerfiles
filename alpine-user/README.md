# Alpine with a custom user (you)

*This is more of an* ***example*** *how to create a user and folder for* ***local development.***

#### Build with defaults:

	$ sudo docker build --force-rm -t me ./

#### Pass with your user ID and name:

	$ sudo docker build --force-rm --build-arg UID=$(id -u) --build-arg USERNAME=$(id -un) -t me ./

#### Example with a volume and the current dir as container name:

	# opens a shell in '/app' working dir
	$ sudo docker run --rm -itv `pwd`:/app --name $(basename `pwd`) me

#### Need root access?

	# assume there is a container running named like your current dir, so run from another terminal
	$ sudo docker exec -itu root $(basename `pwd`) sh

#### Need to persist latest mods?

	$ sudo docker commit $(basename `pwd`) me

##### But you will need to delete `<none>` images manually:

	$ sudo docker images

*(better write a Dockerfile...)*
