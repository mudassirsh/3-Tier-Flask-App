
# # DB - Subnet Group
# variable "db_subnets_ids" {
#   type = list(string)
#   default = db_subnet_id #= db_subnet_id
# }



# DB - Subnet Group
resource "aws_db_subnet_group" "db_subnet" {
  #name = "e_db-subnet"
  #count = length(var.database_subnet_cidrs)
  # subnet_ids = [for value in aws_subnet.database_subnet: value.id]
  #subnet_ids = toset([for subnet in aws_subnet.database_subnets : subnet.id])
  subnet_ids = [aws_subnet.database_subnet[0].id, aws_subnet.database_subnet[1].id]
  #subnet_ids = element(aws_subnet.database_subnet.id, count.index)
  # subnet_ids = aws_subnet.database_subnet.id.count.index

  tags = {
    Name = "My DB subnet group"
  }
}




# DB - RDS Instance
resource "aws_db_instance" "db_postgres" {
  allocated_storage       = 256 # gigabytes 
  backup_retention_period = 7   # in days 
  db_subnet_group_name    = aws_db_subnet_group.db_subnet.name # DB - Subnet Group
  engine                  = "postgres" #var.db_rds_instance_engine
  engine_version          = "14.9" #var.db_rds_instance_engine_version
  identifier              = "dbpostgres" #var.db_rds_instance_identifier
  instance_class          = "db.t3.micro" #var.db_rds_instance_instance_class
  multi_az                = false # var.db_rds_instance_multi_az
  db_name                 = "flaskdb" #var.db_rds_instance_name
  username                = "postgres" #var.db_rds_instance_username
  password                = "postgres" #var.db_rds_instance_password
  port                    = 5432 #var.db_rds_instance_port
  publicly_accessible     = false #var.db_rds_instance_publicly_accessible
  storage_encrypted       = true #var.db_rds_instance_storage_encrypted
  storage_type            = "gp2" #var.db_rds_instance_storage_type
  vpc_security_group_ids  = [aws_security_group.db_security_group.id]
  skip_final_snapshot     = true #var.db_rds_instance_skip_final_snapshot
}

