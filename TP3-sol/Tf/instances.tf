# Adapter le nom à l'usage
# un nom doit être unique pour un compte AWS
# donné
resource "aws_key_pair" "kp_wordpress_common" {
  key_name = "kp_wordpress_common"
  # généré par ssh-keygen ...
  public_key = file("../ssh-keys/id_rsa_wordpress_common.pub")
}

resource "aws_security_group" "sg_wordpress_front" {
  name   = "sg_wordpress_front"
  vpc_id = aws_vpc.vpc_wordpress.id
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

resource "aws_security_group" "sg_wordpress_bdd" {
  name   = "sg_wordpress_bdd"
  vpc_id = aws_vpc.vpc_wordpress.id
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
    from_port   = "3306"
    to_port     = "3306"
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24"]
  }
  # autorise icmp (ping)
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "wordpress_front" {
  # Ubuntu 18.04 fournie par AWS
  ami                         = "ami-0bcc094591f354be2"
  instance_type               = "t2.micro"
  key_name                    = "kp_wordpress_common"
  vpc_security_group_ids      = [aws_security_group.sg_wordpress_front.id]
  subnet_id                   = aws_subnet.subnet_wordpress.id
  private_ip                  = "10.0.0.1"
  associate_public_ip_address = "true"
  user_data                   = file("../Scripts/wordpress_front_init.sh")
  tags = {
    Name = "wordpress_front"
  }
}

resource "aws_instance" "wordpress_bdd" {
  # Ubuntu 18.04 fournie par AWS
  ami                         = "ami-0bcc094591f354be2"
  instance_type               = "t2.micro"
  key_name                    = "kp_wordpress_common"
  vpc_security_group_ids      = [aws_security_group.sg_wordpress_bdd.id]
  subnet_id                   = aws_subnet.subnet_wordpress.id
  private_ip                  = "10.0.0.100"
  associate_public_ip_address = "true"
  user_data                   = file("../Scripts/wordpress_bdd_init.sh")
  tags = {
    Name = "wordpress_bdd"
  }
}


output "wordpress_front_ip" {
  value = "${aws_instance.wordpress_front.*.public_ip}"
}

output "wordpress_bdd_ip" {
  value = "${aws_instance.wordpress_bdd.*.public_ip}"
}

