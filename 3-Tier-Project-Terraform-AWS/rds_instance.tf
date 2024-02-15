

# DB - Subnet Group
resource "aws_db_subnet_group" "db_subnet" {
  subnet_ids = [aws_subnet.database_subnet[0].id, aws_subnet.database_subnet[1].id]
  tags = {
    Name = "My DB subnet group"
  }
}



# DB - RDS Instance
resource "aws_db_instance" "db_postgres" {
  allocated_storage       = 256 # gigabytes 
  backup_retention_period = 7   # in days 
  db_subnet_group_name    = aws_db_subnet_group.db_subnet.name # DB - Subnet Group
  engine                  = "postgres" 
  engine_version          = "14.9" 
  identifier              = "dbpostgres" 
  instance_class          = "db.t3.micro" 
  multi_az                = false 
  db_name                 = "flaskdb" 
  username                = "postgres" 
  password                = "postgres" 
  port                    = 5432 
  publicly_accessible     = false 
  storage_encrypted       = true 
  storage_type            = "gp2" 
  vpc_security_group_ids  = [aws_security_group.db_security_group.id]
  skip_final_snapshot     = true 
}

