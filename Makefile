GO_MODULE := github.com/k-vanio/grpc-proto

.PHONY: tidy protoc clean
tidy:
	go mod tidy

clean:
ifeq ($(OS),Windows_NT)
	if exist "protoc" rd /s /q internal/proto-gen
else
	rm -fR ./internal/proto-gen
endif

generate:
	protoc --go_out=module=${GO_MODULE}:. --go-grpc_out=module=${GO_MODULE}:. ./proto/**/*.proto


.PHONY: build
build: clean generate tidy

#install:
#	sudo apt-get install -y protobuf-compiler golang-goprotobuf-dev
#	go install google.golang.org/protobuf/cmd/protoc-gen-go
#	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc
#	curl -OL https://github.com/google/protobuf/releases/download/v3.6.0/protoc-3.6.0-linux-x86_64.zip
#	unzip protoc-3.6.0-linux-x86_64.zip -d protoc3
#	sudo mv protoc3/bin/* /usr/local/bin
#	sudo mv protoc3/include/* /usr/local/include/
#	sudo chown $USER /usr/local/bin/protoc
#	sudo chown -R $USER /usr/local/include/google