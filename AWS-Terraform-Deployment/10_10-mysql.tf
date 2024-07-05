/*########################################################
RDS Database Create

########################################################*/
resource "mysql_database" "VTC_Service-Moodle" {
  name = var.Moodle-Database-Name
  
  depends_on = [
    module.aurora_mysql_v2
  ]
}