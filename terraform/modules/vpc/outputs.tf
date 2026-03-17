output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_1_id" {
  description = "The ID of public subnet 1"
  value       = aws_subnet.public_subnet_1.id
}

output "public_subnet_2_id" {
  description = "The ID of public subnet 2"
  value       = aws_subnet.public_subnet_2.id
}

output "private_app_subnet_1_id" {
  description = "The ID of private app subnet 1"
  value       = aws_subnet.private_app_subnet_1.id
}

output "private_app_subnet_2_id" {
  description = "The ID of private app subnet 2"
  value       = aws_subnet.private_app_subnet_2.id
}

output "private_db_subnet_1_id" {
  description = "The ID of private db subnet 1"
  value       = aws_subnet.private_db_subnet_1.id
}

output "private_db_subnet_2_id" {
  description = "The ID of private db subnet 2"
  value       = aws_subnet.private_db_subnet_2.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]
}

output "private_app_subnet_ids" {
  description = "List of private app subnet IDs"
  value = [
    aws_subnet.private_app_subnet_1.id,
    aws_subnet.private_app_subnet_2.id
  ]
}

output "private_db_subnet_ids" {
  description = "List of private db subnet IDs"
  value = [
    aws_subnet.private_db_subnet_1.id,
    aws_subnet.private_db_subnet_2.id
  ]
}