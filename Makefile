# Use default go1.8 GOPATH if it isn't user defined
GOPATH ?= ${HOME}/go

# Environment variables set when running the Go compiler.
GO_BUILD_ENVVARS = \
	GOOS=linux \
	GOARCH=amd64 \
	CGO_ENABLED=0 \

.PHONY: help
all: help
help: Makefile
	@echo
	@echo " Choose a command run in "$(PROJECTNAME)":"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo

## Install
install:
	@echo "Installing gRPC"
	@go get -u google.golang.org/grpc
	@echo "Installing protoc"
	@go get -u github.com/golang/protobuf/protoc-gen-go
	@export PATH=$PATH:$GOPATH/bin

generate:
	@protoc --go_out=. proto/*.proto