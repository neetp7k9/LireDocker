FROM java 
MAINTAINER neetp7k9  <neetp7k9@gmail.com>
RUN apt-get -y update && apt-get upgrade -y && apt-get -y dist-upgrade && apt-get -y autoremove 
RUN apt-get install -y ant && \
    apt-get install -y build-essential cmake && \
    apt-get install -y zlib1g-dev libjpeg-dev libwebp-dev libpng-dev libtiff5-dev libjasper-dev libopenexr-dev libgdal-dev && \
    apt-get install -y libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev && \
    git clone git://github.com/Itseez/opencv.git && cd opencv && git checkout 2.4 && mkdir build && cd build && \
    cmake -DBUILD_SHARED_LIBS=OFF .. && make -j8 && make install 
RUN git clone https://github.com/dermotte/LIRE.git && cd LIRE && \
    ant dist&& \
    cd dist && \
    wget -O junit-4.12.jar http://search.maven.org/remotecontent?filepath=junit/junit/4.12/junit-4.12.jar && \
    wget -O hamcrest-core-1.3.jar http://search.maven.org/remotecontent?filepath=org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar
RUN cd LIRE && \
    javac -cp ./dist/junit-4.12.jar:./dist/hamcrest-core-1.3.jar:./dist/lire.jar ./src/test/java/net/semanticmetadata/lire/TestProperties.java 
