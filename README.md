# AWS Scalable Web Application

## Project Overview
This project demonstrates the deployment of a secure, scalable, and highly available web application architecture on AWS. The system uses public and private subnets, an internet-facing Application Load Balancer, EC2 instances in private subnets, Auto Scaling, CloudWatch monitoring, and an RDS MySQL database.

## Architecture
The architecture includes:
- VPC with public and private subnets across two Availability Zones
- Internet Gateway for public connectivity
- NAT Gateways for private subnet outbound access
- Application Load Balancer in public subnets
- Auto Scaling Group for EC2 instances in private subnets
- RDS MySQL database in a private subnet
- CloudWatch custom memory monitoring
- Terraform automation for Auto Scaling and CloudWatch alarms

## AWS Services Used
- Amazon VPC
- Amazon EC2
- Auto Scaling Group
- Application Load Balancer
- Amazon RDS
- Amazon CloudWatch
- NAT Gateway
- Internet Gateway

## Key Features
- Highly available network design using multiple Availability Zones
- Private EC2 instances protected from direct public access
- Load balancing across multiple EC2 instances
- Auto Scaling based on monitoring conditions
- Custom CloudWatch memory metric
- RDS database hosted privately
- Terraform-based infrastructure automation

## Terraform Automation
Terraform was used to automate:
- Launch Template creation
- Auto Scaling Group creation
- Scaling policies
- CloudWatch alarms

## Report
The full project report is available here:

`docs/Cloud_Architecture_Assignment_1_Report.pdf`

## Skills Demonstrated
- AWS cloud infrastructure design
- Networking and subnetting
- Load balancing
- Auto Scaling
- Cloud monitoring
- Infrastructure as Code using Terraform
- Cloud security fundamentals

## Lessons Learned
This project helped me understand how AWS infrastructure components work together to create a secure, scalable, and highly available web application environment.
