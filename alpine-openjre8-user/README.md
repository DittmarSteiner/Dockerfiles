# OpenJDK 8 (JRE) on Alpine 

**With a custom user (you) and “Unlimited JCE Policy JDK 8”.**

***Ready-to-use*** *as well as for* ***local development.***

#### Build with defaults:

	$ sudo docker build --force-rm -t java8-me ./

#### Pass with your user ID and name:

	$ sudo docker build --force-rm --build-arg UID=$(id -u) --build-arg USERNAME=$(id -un) -t java8-me ./

#### Example with a volume and the current dir as container name:

	# just check
	$ sudo docker run --rm -it java8-me java -version
	$ sudo docker run --rm -it java8-me id

	# opens a shell in '/app' working dir, then type ls -l
	$ sudo docker run --rm -itv `pwd`:/app --name $(basename `pwd`) java8-me

	# more practial: executes 'myappp.jar' in your in your local current dir
	$ sudo docker run --rm -itv `pwd`:/app --name $(basename `pwd`) java8-me java -jar myapp.jar

#### Need root access?

	# assume there is a container running named like your current dir, so run from another terminal
	$ sudo docker exec -itu root $(basename `pwd`) sh

#### Need to persist latest mods?

	$ sudo docker commit $(basename `pwd`) java8-me

##### But you will need to delete `<none>` images manually:

	$ sudo docker images

*(better write a Dockerfile...)*
