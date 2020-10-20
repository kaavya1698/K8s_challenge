### ec2 instance for etcd #######
resource "aws_instance" "etcd" {
    count = 3
    ami = var.ami // Amazon Linux 2 AMI (HVM
    instance_type = "t2.micro"

    subnet_id = aws_subnet.kubernetes.id
    private_ip = cidrhost("10.43.0.0/16", 10 + count.index)
    associate_public_ip_address = true

    availability_zone = "us-east-1a"
    vpc_security_group_ids = [aws_security_group.kubernetes.id]
    key_name = "my-keypair"

    tags ={
      #Owner = "${var.owner}"
      Name = "etcd-${count.index}"
      ansibleFilter = "Kubernetes01"
      ansibleNodeType = "etcd"
      ansibleNodeName = "etcd${count.index}"
    }
}

### ec2 instance for control plane #######
resource "aws_instance" "controller" {

    count = 3
    ami = var.ami // Amazon Linux 2 AMI (HVM
    instance_type = "t2.micro"

    iam_instance_profile = aws_iam_instance_profile.kubernetes.id

    subnet_id = aws_subnet.kubernetes.id
    private_ip = cidrhost(var.vpc_cidr, 20 + count.index)
    associate_public_ip_address = true # Instances have public, dynamic IP
    source_dest_check = false # TODO Required??(to allow sending packets from IPs not matching the IP assigned to the machine by AWS (for inter-Container communication).)

    availability_zone = "us-east-1a"
    vpc_security_group_ids = [aws_security_group.kubernetes.id]
    key_name = "my-keypair"

    tags ={
      #Owner = "${var.owner}"
      Name = "controller-${count.index}"
      ansibleFilter = "Kubernetes01"
      ansibleNodeType = "controller"
      ansibleNodeName = "controller${count.index}"
    }
}

### ec2 instance for workers #######
resource "aws_instance" "worker" {
    count = 3
    ami = var.ami // Amazon Linux 2 AMI (HVM
    instance_type = "t2.micro"

    subnet_id = aws_subnet.kubernetes.id
    private_ip = cidrhost(var.vpc_cidr, 30 + count.index)
    associate_public_ip_address = true # Instances have public, dynamic IP
    source_dest_check = false # TODO Required??

    availability_zone = "us-east-1a"
    vpc_security_group_ids = [aws_security_group.kubernetes.id]
    key_name = "my-keypair"

    tags ={
      #Owner = "${var.owner}"
      Name = "worker-${count.index}"
      ansibleFilter = "Kubernetes01"
      ansibleNodeType = "worker"
      ansibleNodeName = "worker${count.index}"
    }
}