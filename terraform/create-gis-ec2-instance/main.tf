/*
* Create an EC2 instance w/ some gis related software we need for our showcase
* of the new background map.
* QGIS, Mapcache, ...
*/

provider "aws" {
  region = "eu-central-1"
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  
  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags {
    Name = "allow_all"
  }
}

resource "aws_instance" "qgis-gis-server" {
  availability_zone = "eu-central-1a"    
  ami = "ami-1e339e71" 
  instance_type = "t2.micro"
  key_name = "aws-demo"
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
  user_data = "${file("qgis-gis-server.conf")}"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 12
    delete_on_termination = true
  }

  tags {
    Name = "qgis-gis-server"
  }
}

output "public_ip" {
  value = "${aws_instance.qgis-gis-server.public_ip}"
}