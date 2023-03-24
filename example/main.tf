module "metabase" {
  source             = "../"
  public_subnet_ids  = ["${aws_subnet.a.id}","${aws_subnet.b.id}"]
  private_subnet_ids = ["${aws_subnet.a.id}","${aws_subnet.b.id}"]
  vpc_id             = aws_vpc.this.id
  domain             = "metabase.example.com"
  certificate_arn    = "Get this from your AWS Certificate Manager (ACM) in the console"
  zone_id            = "Create a Route 53 hosted zone in the AWS dashboard and get the id"
}

resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "mb-vpc"
  }
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}

resource "aws_subnet" "a" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet("10.0.0.0/16", 4, 0)
  availability_zone = "eu-central-1a" # Modify this to suit your region
}

resource "aws_subnet" "b" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet("10.0.0.0/16", 4, 1)
  availability_zone = "eu-central-1b" # Modify this to suit your region
}

provider "aws" {
  region = "eu-central-1"             # Modify this to suit your region
}
