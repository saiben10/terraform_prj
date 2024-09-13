provider "aws" {
  #region = "us-east-1"
  region = "ap-northeast-1"
}

variable "ami" {
  description = "value"
}

variable "user_names" {

  type = list(string)

  default = [ "user1","user2","user3" ]  
}

##For_each Loop

variable "subnets" {

  type = map(object({
    cidr_block = string
    availability_zone = string
  }))
  default = {
    "subnet1" = {
      cidr_block = "10.0.4.0/24"
      availability_zone = "ap-northeast-1c"
      
    }
    "subnet2" = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "ap-northeast-1d"
      
    }
  }
  
}

resource "aws_subnet" "sb_for_loop" {
  for_each = var.subnets
  vpc_id = data.aws_vpc.aws-vpc-existing-id.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  
}


resource "aws_iam_user" "user" {
  count = length(var.user_names)
  name = var.user_names[count.index]
}


data "aws_vpc" "aws-vpc-existing-id" {
  id = "vpc-01676ac0b24e39573"
}

resource "aws_vpc" "import" {
  #id = "vpc-0981e1a2f209f10c0"
  cidr_block = "10.0.0.0/24"
  
}

resource "aws_subnet" "sub" {
  vpc_id                  = data.aws_vpc.aws-vpc-existing-id.id
  cidr_block              = "10.0.1.0/24"
  # availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "example-subnet"
  }
}

variable "instance_type" {
  description = "value"
  type = map(string)

  default = {
    "dev" = "t2.micro"
    "stage" = "t2.medium"
    "prod" = "t2.xlarge"
  }
}

variable "s3_bucket" {
  type = map(string)

  default = {
    "dev" = "dev-s3"
     "prod" = "prod-s3"
  }
}

variable "dynamodb" {
  type = map(string)

  default = {
    "dev" = "dev-dynamo"
    "prod" = "prod-dynamo"
  }
}

module "ec2_instance" {
  source = "./modules/ec2"
  ami = var.ami
  instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
}

module "s3_bucket" {
  source = "./modules/s3"
  bucket_name = "my-bucketdev-${terraform.workspace}"
  }

# module "dynamodb_table" {
#   source = "./modules/dynamo_db"
#   dynamodb = 
#   hash_key     = "LockID"
#   hash_key_type  = "S"                 # String type (or N for number)
#   read_capacity  = 5                   # For provisioned mode
#   write_capacity = 5      
# }

# module "dynamo_db" {
#   source = "./modules/dynamo_db"

#   dynamodb       = "demo-dynamo"
#   hash_key       = "LockID"
#   hash_key_type = "S"
#   read_capacity = 5
#   write_capacity = 5
# }

