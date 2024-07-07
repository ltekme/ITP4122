/*########################################################
Domain Resource

########################################################*/
resource "aws_route53_zone" "VTC_Service-Primary" {
  name = var.VTC_Service-Primary-Domain
}


/*########################################################
Domain Record for Moodle
########################################################*/
resource "aws_route53_record" "VTC_Service-Moodle" {
  zone_id = aws_route53_zone.VTC_Service-Primary.zone_id
  name    = "moodle.${aws_route53_zone.VTC_Service-Primary.name}"
  type    = "A"
  ttl     = 300
  records = [data.external.VTC_Service-MOODLE-Ingress_8080-External_Endpoint.result.hostname]
}