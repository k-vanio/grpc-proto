GO_MODULE := github.com/k-vanio/grpc-proto

.PHONY: tidy protoc clean
tidy:
	go mod tidy

clean:
ifeq ($(OS),Windows_NT)
	if exist "protoc" rd /s /q proto-gen
else
	rm -fR ./protogen
endif

generate:
	protoc --go_opt=module=${GO_MODULE} --go_out=. ./proto/**/*.proto

.PHONY: build
build: install clean generate tidy

install:
	sudo apt-get install -y protobuf-compiler golang-goprotobuf-dev
	go get -u google.golang.org/protobuf/cmd/protoc-gen-go
	go get -u google.golang.org/grpc/cmd/protoc-gen-go-grpc
#	curl -OL https://github.com/google/protobuf/releases/download/v3.6.0/protoc-3.6.0-linux-x86_64.zip
#	unzip protoc-3.6.0-linux-x86_64.zip -d protoc3
#	sudo mv protoc3/bin/* /usr/local/bin
#	sudo rm -R /usr/local/include/google
#	sudo mv protoc3/include/* /usr/local/include/
#	sudo chown $USER /usr/local/bin/protoc
#	sudo chown -R $USER /usr/local/include/google