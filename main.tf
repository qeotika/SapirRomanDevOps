terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  region = "eu-west-3"
}
resource "aws_vpc" "Roman-dev-vpc" {
  cidr_block = "192.0.2.0/24"
  tags = {"Name" = "Roman-dev-vpc"}
  
}
resource "aws_subnet" "Roman-dev-subnet" {
  vpc_id = aws_vpc.Roman-dev-vpc.id
  cidr_block = "192.0.2.0/27"
  tags = {"Name" = "Roman-k8s-subnet"}
  
}
resource "aws_internet_gateway" "igw" {
  vpc_id=aws_vpc.Roman-dev-vpc.id
  tags={
    Name= "RomanIgw"
  }
  
}
resource "aws_route" "routeIGW" {
  route_table_id = aws_vpc.Roman-dev-vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
  
}