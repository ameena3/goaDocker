FROM golang:1.13.3

#Copy the source code 
RUN mkdir -p ./calc/design
COPY ./src/design.go /go/src/calc/design/
WORKDIR /go/src/calc

# Set up the installation directory for go
ENV GOBIN=/go/bin

# Initialize gomodules
RUN go mod init calc

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

#Proceed with protoc installation
RUN wget -O /go/bin/protoc.zip https://github.com/protocolbuffers/protobuf/releases/download/v3.10.0/protoc-3.10.0-linux-x86_64.zip
RUN unzip /go/bin/protoc.zip -d /temp
RUN cp /temp/bin/protoc /go/bin/
RUN goa gen calc/design
RUN goa example calc/design
RUN go install ./cmd/calc 

#ENTRYPOINT [ "calc" ]