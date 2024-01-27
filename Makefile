GO_MODULE := github.com/k-vanio/grpc-proto

.PHONY: tidy protoc clean
tidy:
	go mod tidy

clean:
ifeq ($(OS),Windows_NT)
	if exist "protoc" rd /s /q protogen
else
	rm -fR ./protogen
endif

generate:
	protoc --go_opt=module=${GO_MODULE} --go_out=. ./proto/**/*.proto

.PHONY: build
build: clean protoc tidy
