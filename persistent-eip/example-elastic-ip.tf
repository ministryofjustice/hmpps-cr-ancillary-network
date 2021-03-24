//resource "aws_eip" "delius_ndelius_az1_lb" {
//  vpc = true
//  tags = merge(
//    var.tags,
//    {
//      "Name" = "${var.environment_name}-delius-ndelius-az1-lb"
//    },
//    {
//      "Do-Not-Delete" = "true"
//    },
//  )
//  lifecycle {
//    prevent_destroy = true
//  }
//}