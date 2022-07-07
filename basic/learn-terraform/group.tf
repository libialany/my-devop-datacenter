resource "aws_security_group" "ec2_basic" {
    name = "ec2_basic"
    vpn_id = aws_default_vpc.default.id
    #sub-blocks for specifying the rules for inbound and outbound network traffic respectively
    ingress {}
    egres{}
}
