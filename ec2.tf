
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "ty"
  security_groups   = ["${aws_security_group.allow_from_my_ip.name}"]
  user_data = data.template_file.myuserdata.template
  

  tags = {
    Name = "Nginx_web_server"
  }
}

data "template_file" "myuserdata" {
  template = "${file("${path.cwd}/myuserdata.tpl")}"
}