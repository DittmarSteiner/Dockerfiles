# Maven with OpenJDK 8 (JRE) on Alpine 

**With a custom user (you) and “Unlimited JCE Policy JDK 8”.**  
For local development.

#### Build image (example)

	$ sudo docker build --force-rm -t maven ./
	# or with your current uder ID (if not 1000)
	$ sudo docker build --force-rm --build-arg UID=$(id -u) -t maven ./

##### Verify (removes the container immediately):

	$ sudo docker run --rm -it maven java -version
	$ sudo docker run --rm -it maven mvn --version
	$ sudo docker run --rm -it -v ~/.m2:/home/maven/.m2 maven ls -hAlF /home/maven/.m2

#### Now build your local project with containerized Maven!

	$ cd <path-to-your-pom.xml>
	$ sudo docker run --rm -it -v ~/.m2:/home/maven/.m2 -v $(pwd):/project maven mvn clean test install

##### Use an alias for your containerized Maven!
	$ alias cmvn='sudo docker run --rm -it -v ~/.m2:/home/maven/.m2 -v $(pwd):/project maven mvn'
	$ cmvn --version
	$ cmvn clean test install
