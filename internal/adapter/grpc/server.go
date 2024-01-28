package grpc

import (
	"fmt"
	"log"
	"net"

	"github.com/k-vanio/grpc-proto/internal/domain"
	"github.com/k-vanio/grpc-proto/internal/proto-gen/payment"
	"google.golang.org/grpc"
)

type GrpAdapter struct {
	servicePayment domain.Service
	port           int
	server         *grpc.Server
	payment.UnimplementedPaymentServiceServer
}

func NewGrpAdapter(servicePayment domain.Service, port int) *GrpAdapter {
	return &GrpAdapter{
		servicePayment: servicePayment,
		port:           port,
	}
}

func (g *GrpAdapter) Start() error {
	var err error

	lis, err := net.Listen("tcp", fmt.Sprintf(":%d", g.port))
	if err != nil {
		return err
	}

	log.Printf("gRPC server listening on port %d\n", g.port)

	g.server = grpc.NewServer()
	payment.RegisterPaymentServiceServer(g.server, g)

	if err := g.server.Serve(lis); err != nil {
		return err
	}

	return nil
}

func (g *GrpAdapter) Stop() {
	g.server.Stop()
}
