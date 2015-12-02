MVN=sudo docker run -it --rm --privileged -v $(CURDIR):/usr/src/mymaven:rw -v ~/.m2:/root/.m2:rw -w /usr/src/mymaven maven:3-jdk-7 mvn

default: clean package

package:
	@$(MVN) package

clean:
	@$(MVN) clean
