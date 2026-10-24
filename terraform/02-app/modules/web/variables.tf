variable "name" {
    type = string
}

variable "namespace" {
    type = string
}

variable "image" {
    type = string
    default = "nginx:1.25"
}

variable "replicas" {
    type = number
    default = 2
}