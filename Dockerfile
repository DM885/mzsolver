FROM sejkom/dind


#Docker image to perform some basic computation

ARG arg
RUN if [ "x$arg" = "x" ] ; then echo Argument not provided ; else echo Argument is $arg ; fi
#RUN docker build -t sejkom/dind arg=2 .

#install node 16
RUN apt update
RUN apt install -y curl
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt install -y nodejs

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm ci --only=production

# Copy all files to directory #####
COPY . .

# CMD ["npm", "run", "start"]
ENTRYPOINT ["bash","/usr/src/app/start-everything.sh"]
