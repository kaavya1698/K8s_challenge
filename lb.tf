## Creating load balancer ####
resource "aws_elb" "kubernetes_api" {
    name = "kube-api"
    instances = [aws_instance.controller[0].id, aws_instance.controller[1].id, aws_instance.controller[2].id ]
    subnets = [aws_subnet.kubernetes.id]
    cross_zone_load_balancing = false

    security_groups = [aws_security_group.kubernetes_api.id]

    listener {
      lb_port = 6443
      instance_port = 6443
      lb_protocol = "TCP"
      instance_protocol = "TCP"
    }

    health_check {
      healthy_threshold = 2
      unhealthy_threshold = 2
      timeout = 15
      target = "HTTP:8080/healthz"
      interval = 30
    }
}