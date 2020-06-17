
data "aws_region" "current" {}
data "aws_caller_identity" "identity" {}

module "api_gateway_lambda" {
  source                       = "terraform-aws-modules/lambda/aws"
  policies                     = var.attached_policies
  function_name                = var.function_name
  description                  = var.description
  handler                      = var.handler
  runtime                      = var.runtime
  publish                      = false
  layers                       = var.layers
  timeout                      = 30
  create_async_event_config    = true
  maximum_event_age_in_seconds = 120
  maximum_retry_attempts       = 0
  environment_variables        = var.env_vars

  #todo check this out
  create_package         = false
  local_existing_package = var.file_name

  allowed_triggers = {
    APIGatewayAny = {
      service = "apigateway"
      arn     = "arn:aws:execute-api:${data.aws_region.current}:${data.aws_caller_identity.identity.account_id}:${var.rest_api_id}/*"
    }
  }
}
