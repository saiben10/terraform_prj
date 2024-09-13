terraform {
  backend "s3" {
    bucket = "my-bucketdev-default"
    key = "terraform/state/dev/terraform.tfstate"
    #"terraform/state/${terraform.workspace}/terraform.tfstate"
    #dynamodb_table = "demo-dynamo"
    region = "ap-northeast-1"
    encrypt        = true

    
  }
}