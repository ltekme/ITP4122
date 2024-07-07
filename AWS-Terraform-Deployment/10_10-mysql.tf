/*########################################################
RDS Database Create

########################################################*/
# resource "mysql_database" "VTC_Service-Moodle" {
#   name = var.Moodle-Database-Name

#   depends_on = [
#     module.aurora_mysql_v2,
#     time_sleep.VTC_Service-RDS-wait_30_seconds-mysql
#   ]
# }


/*########################################################
RDS Database Delete Wait

########################################################*/
# resource "time_sleep" "VTC_Service-RDS-wait_30_seconds-mysql" {
#   // wait 30 seconds before destroying
#   depends_on = [module.aurora_mysql_v2]

#   destroy_duration = "3m"
# }
