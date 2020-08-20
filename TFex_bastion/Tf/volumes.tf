resource "aws_ebs_volume" "volume_data" {
  availability_zone = aws_instance.tfinstance1.availability_zone
  size = 1
}

resource "aws_volume_attachment" "tfinstance1_volume_data" {
  device_name = "/dev/sdh"
  volume_id = aws_ebs_volume.volume_data.id
  instance_id = aws_instance.tfinstance1.id
}
