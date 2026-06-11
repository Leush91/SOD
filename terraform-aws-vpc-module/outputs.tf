output "vpc_id" {
  description = "ID-ul VPC-ului creat de modul"
  value       = aws_vpc.this.id
}

output "vpc_arn" {
  description = "ARN-ul VPC-ului creat de modul"
  value       = aws_vpc.this.arn
}

output "vpc_cidr_block" {
  description = "CIDR block-ul VPC-ului creat de modul"
  value       = aws_vpc.this.cidr_block
}