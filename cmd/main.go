package main

import (
	"log"

	"github.com/k-vanio/grpc-proto/config"
	"github.com/k-vanio/grpc-proto/internal/adapter/grpc"
	"github.com/k-vanio/grpc-proto/internal/application/payment"
	"github.com/k-vanio/grpc-proto/internal/domain"
)

func main() {

	cfg := config.NewConfig(config.WithID)

	log.Println(cfg)

	var service domain.Service = payment.NewService()
	var app *grpc.GrpAdapter = grpc.NewGrpAdapter(service, 8080)

	defer app.Stop()
	if err := app.Start(); err != nil {
		panic(err)
	}
}
