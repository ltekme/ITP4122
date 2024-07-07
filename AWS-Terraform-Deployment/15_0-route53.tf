/*########################################################
Domain Resource

########################################################*/
resource "aws_route53_zone" "VTC_Service-Primary" {
  name = var.VTC_Service-Primary-Domain

  lifecycle {
    prevent_destroy = true
  }
}


/*########################################################
Domain Record for Moodle

########################################################*/
resource "aws_route53_record" "VTC_Service-Primary-Moodle" {
  zone_id = aws_route53_zone.VTC_Service-Primary.zone_id
  name    = "moodle.${aws_route53_zone.VTC_Service-Primary.name}"
  type    = "A"

  alias {
    name                   = data.external.VTC_Service-MOODLE-Ingress_8080-External_Endpoint.result.hostname
    zone_id                = data.aws_elb_hosted_zone_id.main.id
    evaluate_target_health = false
  }
}
