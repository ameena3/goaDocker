package design

import (
	. "goa.design/goa/v3/dsl"
)

var _ = API("calc", func() {
	Title("Calculator Service")
	Description("Service for adding numbers, a Goa teaser")
	Server("calc", func() {
		Host("0.0.0.0", func() {
			URI("http://0.0.0.0:8000")
		})
	})
})

var _ = Service("calc", func() {
	Description("The calc service performs operations on numbers.")

	Method("add", func() {
		Payload(func() {
			Field(1, "a", Int, "Left operand")
			Field(2, "b", Int, "Right operand")
			Required("a", "b")
		})

		Result(Int)

		HTTP(func() {
			GET("/add/{a}/{b}")
		})

	})

	Files("/openapi.json", "./gen/http/openapi.json")
})
