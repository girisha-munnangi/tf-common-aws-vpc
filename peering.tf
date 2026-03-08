resource "aws_vpc_peering_connection" "default" {
    count = var.is_peering_required ? 1 : 0
    peer_vpc_id = data.aws_vpc.default.id
    vpc_id = aws_vpc.this.id
    auto_accept = true
    accepter {
        allow_remote_vpc_dns_resolution = true
    }
    requester {
        allow_remote_vpc_dns_resolution = true
    }
    tags = merge (
        local.common_tags,
        {
            Name = "${var.project}-${var.environment}-default"
        }
    )
}
resource "aws_route" "public_peering" {
    count = var.is_peering_required ? 1 : 0
    route_table_id = aws_route_table.public.in
    destination_cidr_block = data.aws_vpc.default.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection_default[count.index].id
}