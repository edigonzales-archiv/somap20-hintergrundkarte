/*
* Create a EBS volume for the geodata (Landeskarten)
*/

provider "aws" {
  region = "eu-central-1"
}

resource "aws_ebs_volume" "lk" {
  availability_zone = "eu-central-1a"
  size = 50
  type = "gp2"
  tags {
    Name = "ch.swisstopo.landeskarten"
  }  
}
