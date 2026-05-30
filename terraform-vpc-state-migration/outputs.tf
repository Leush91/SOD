output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.demo_vpc.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the created VPC"
  value       = aws_vpc.demo_vpc.cidr_block
}
