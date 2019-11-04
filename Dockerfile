FROM golang:1.13.3

# Set up the installation directory for go
ENV GOBIN=/go/bin
ENV GO111MODULE=on

# install Goa from source
RUN go get -u goa.design/goa/v3
RUN go get -u goa.design/goa/v3/...

# get the protoc compiler 
RUN go get -d -u github.com/golang/protobuf/protoc-gen-go
RUN go install github.com/golang/protobuf/protoc-gen-go

#get some useful tools installed on the image
RUN apt update && apt upgrade -y 
RUN apt install unzip -y 
RUN apt install vim -y
RUN apt install net-tools -y
RUN apt install git -y

#Proceed with protoc installation
RUN wget -O /go/bin/protoc.zip https://github.com/protocolbuffers/protobuf/releases/download/v3.10.0/protoc-3.10.0-linux-x86_64.zip
RUN unzip /go/bin/protoc.zip -d /temp
RUN cp /temp/bin/protoc /go/bin/

#Copy the source code 
RUN mkdir -p ./work/design
COPY ./src/design.go /go/src/work/design/
WORKDIR /go/src/work

# Initialize gomodules
RUN go mod init 

    