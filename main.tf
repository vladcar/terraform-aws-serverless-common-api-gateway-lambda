
data "aws_region" "current" {}
data "aws_caller_identity" "identity" {}

module "lambda" {
  source                         = "vladcar/serverless-common-basic-lambda/aws"
  source_path                    = var.source_path
  function_name                  = var.function_name
  handler                        = var.handler
  memory_size                    = var.memory_size
  description                    = var.description
  reserved_concurrent_executions = var.reserved_concurrent_executions
  timeout                        = var.timeout
  create_async_invoke_config     = var.create_async_invoke_config
  maximum_event_age_in_seconds   = var.maximum_event_age_in_seconds
  maximum_retry_attempts         = var.maximum_retry_attempts
  destination_on_failure         = var.destination_on_failure
  destination_on_success         = var.destination_on_success
  runtime                        = var.runtime
  layers                         = var.layers
  env_vars                       = var.env_vars
  tags                           = var.tags
  create_role                    = var.create_role
  execution_role                 = var.execution_role
  attached_policies              = var.attached_policies
  enable_vpc_config              = var.enable_vpc_config
  subnet_ids                     = var.subnet_ids
  security_group_ids             = var.security_group_ids
  tracing_mode                   = var.tracing_mode
}

resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.lambda_function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.identity.account_id}:${var.rest_api_id}/*"
}
