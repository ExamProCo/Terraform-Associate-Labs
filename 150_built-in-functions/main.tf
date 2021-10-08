terraform {

}

variable "str" {
	type = string
	default = ""
}
variable "items" {
	type = list
	default = [null,null,"","last"]
}

variable "stuff" {
	type = map
	default = {
		"hello" = "world",
		"goodbye" = "moon"
	}
}