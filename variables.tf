
variable "file_name" {
  type = string
}

variable "function_name" {
  type = string
}

variable "handler" {
  type = string
}

variable "runtime" {
  type = string
}

variable "memory_size" {
  type = number
}

variable "rest_api_id" {
  type = string
}

variable "attached_policies" {
  type        = list(string)
  description = "A list of IAM policy ARNs. Will be attached to execution role"
}

variable "layers" {
  type        = list(string)
  default     = []
  description = "Lambda layer ARNs"
}

variable "description" {
  type        = string
  description = "lambda function description"
  default     = ""
}

variable "allowed_triggers" {
  description = "Map of allowed triggers to create Lambda permissions"
  type        = map(any)
  default     = {}
}

variable "env_vars" {
  description = "A map that defines environment variables for the Lambda Function."
  type        = map(string)
  default     = {}
}
