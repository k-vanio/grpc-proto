package config

type config struct {
	id   string
	tls  bool
	name string
}

type Func func(*config)

func NewConfig(opts ...Func) *config {
	c := &config{}

	for _, opt := range opts {
		opt(c)
	}

	return c
}

func WithID(c *config) {
	c.id = "123"
}
