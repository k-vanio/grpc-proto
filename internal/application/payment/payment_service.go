package payment

type service struct{}

func NewService() *service {
	return &service{}
}

func (s *service) Generate() int {
	return 0
}
