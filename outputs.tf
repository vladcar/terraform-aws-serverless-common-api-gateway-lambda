output "lambda-arn" {
  value = module.api_gateway_lambda.this_lambda_function_arn
}

output "lambda_invoke_arn" {
  value = module.api_gateway_lambda.this_lambda_function_invoke_arn
}

output "lambda_function_name" {
  value = module.api_gateway_lambda.this_lambda_function_name
}