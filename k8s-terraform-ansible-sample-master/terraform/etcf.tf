#########################
# etcd cluster instances
#########################

resource "aws_instance" "etcd" {
    count = 3
    ami = "ami-0ebc8f6f580a04647"
    instance_type = "${var.etcd_instance_type}"

    subnet_id = "${aws_subnet.kubernetes.id}"
    private_ip = "${cidrhost(var.vpc_cidr, 10 + count.index)}"
    associate_public_ip_address = true # Instances have public, dynamic IP

    availability_zone = "${var.zone}"
    vpc_security_group_ids = ["${aws_security_group.kubernetes.id}"]
    key_name = "${var.default_keypair_name}"

    tags = {
      Owner = "${var.owner}"
      Name = "etcd-${count.index}"
      ansibleFilter = "${var.ansibleFilter}"
      ansibleNodeType = "etcd"
      ansibleNodeName = "etcd${count.index}"
    }
}
