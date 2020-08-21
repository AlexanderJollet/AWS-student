# Adapter le nom à l'usage
# un nom doit être unique pour un compte AWS
# donné
resource "aws_key_pair" "first_key_pair" {
  key_name = "first_key_pair"
  public_key = file("../ssh-keys/id_rsa_first_key_pair.pub")
}

# Adapter le nom à l'usage
resource "aws_security_group" "instance_security" {
  name   = "instance_security"
  vpc_id = aws_vpc.vpc_1.id
  # en entrée
  # autorise ssh de partout
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # autorise http de partout
  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # autorise icmp (ping)
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "instance_app" {
  # Ubuntu 18.04 fournie par AWS
  ami                         = "ami-0bcc094591f354be2"
  instance_type               = "t2.micro"
  key_name                    = "first_key_pair"
  vpc_security_group_ids      = [aws_security_group.sg_tfinstance1.id]
  subnet_id                   = aws_subnet.subnet_1.id
  private_ip                  = "10.42.1.10"
  associate_public_ip_address = "true"
  user_data                   = file("../Scripts/instance_init1.sh")
  tags = {
    Name = "instance_app"
  }
}

resource "aws_instance" "instance_mariadb" {
  # Ubuntu 18.04 fournie par AWS
  ami                         = "ami-0bcc094591f354be2"
  instance_type               = "t2.micro"
  key_name                    = "first_key_pair"
  vpc_security_group_ids      = [aws_security_group.instance_security.id]
  subnet_id                   = aws_subnet.subnet_1.id
  private_ip                  = "10.42.1.11"
  associate_public_ip_address = "true"
  user_data                   = file("../Scripts/instance_init1.sh")
  tags = {
    Name = "instance_mariadb"
  }
}

output "instance_app_ip" {
  value = "${aws_instance.instance_app.*.public_ip}"
}

output "instance_mariadb_ip" {
  value = "${aws_instance.instance_mariadb.*.public_ip}"
}

