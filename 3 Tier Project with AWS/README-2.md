# Infrastructure setup steps in detail


<p align="center">
  <img width="700" height="600" src="https://github.com/mudassirsh/3-Tier-Flask-App/assets/18271814/f268add1-7834-48e1-adef-4572c7fcd23e">
</p>

<br>

- **Create VPC** 

<p align="center">
    <img width="350" height="350" src="https://github.com/mudassirsh/3-Tier-Flask-App/assets/18271814/5e59bb36-8921-439b-9de1-bc7c98c78343">
    <img width="350" height="250" src="https://github.com/mudassirsh/3-Tier-Flask-App/assets/18271814/269c8be0-447d-4f49-8059-b8738afb0df5"> <br><br><br>
    <img width="550" height="250" src="https://github.com/mudassirsh/3-Tier-Flask-App/assets/18271814/5f3cda2a-d823-4a7f-9a46-520b035570f3">
  </p>


- **Create Subnets**

<img align="right" width="400" height="275" src="https://github.com/mudassirsh/3-Tier-Flask-App/assets/18271814/c49d6e00-d7f4-4677-8418-2f4cae88fca3" />


VPC CIDR:			10.0.0.0/24	(IP range: 256)

Subnet  public1 (Zone 1):	10.0.0.0/26		(Range: 10.0.0.0 – 10.0.0.63 = 64)

Subnet private 1 (Zone 1):	10.0.0.64/26		(Range: 10.0.0.64 – 10.0.0.127 = 256)

Subnet private 1 (Zone 2):	10.0.0.128/26		(Range: 10.0.0.128 – 10.0.0.191 = 256)

<br> <br><br>

<p align="center">
  <img width="350" height="300" src="https://github.com/mudassirsh/3-Tier-Flask-App/assets/18271814/4dde466b-4b95-4cfe-8f47-f6efcf08f125"> 
  <img width="350" height="300" src="https://github.com/mudassirsh/3-Tier-Flask-App/assets/18271814/8a4d66cf-dc98-4680-8d02-e47867d42c9b">
</p>


<p align="center">
  <img width="700" height="150" src="https://github.com/mudassirsh/3-Tier-Flask-App/assets/18271814/6ecc6c54-43c9-4f39-b90e-95aef8983fc9">
</p>


<br>

- **Create Public and Private Route Tables** 

<p align="center">
  <img width="350" height="300" src="https://github.com/mudassirsh/3-Tier-Flask-App/assets/18271814/64b2c94c-56b0-4083-b0fe-f0bc7d7a1364">
  <img width="350" height="300" src="https://github.com/mudassirsh/3-Tier-Flask-App/assets/18271814/eaca1954-4cb2-437c-a81f-a89a09bd79d6">
</p>



## Attach Public Route table to Internet gateway

<img align="right" width="550" height="225" src="https://github.com/mudassirsh/3-Tier-Flask-App/assets/18271814/c0276b75-9ef8-4a85-a224-1824ca70dbd3" />


Edit Public table and add another row with 
ip 0.0.0.0 Destination IP means, the traffic 
generated inside this rout table end up where.
As the destination is 0.0.0.0 , so it means 
it ends up to internet.

<br><br>



- **Attached Public Subnet to Public Route Table (PublicRT)** 

<img align="center" width="600" height="450" src="https://github.com/mudassirsh/3-Tier-Flask-App/assets/18271814/72c4b9ce-951d-43a2-92f2-e0ebc12605ab" />


## Attach Private Subnets to Private Route Table (PrivateRT)


<img align="center" width="650" height="350" src="https://github.com/mudassirsh/3-Tier-Flask-App/assets/18271814/fcabc5f4-ac43-4c73-926e-347246815f81" />






- **Create NatGateway in Public1 subnet**

<img align="center" width="550" height="350" src="https://github.com/mudassirsh/3-Tier-Flask-App/assets/18271814/92ae125b-8188-4798-ab3a-3f40b2b55d0d" />

<br><br>

- **Attach Nat Gateway to Private RT  ( Route Tables > Edit routes )**

<img align="center" width="775" height="350" src="https://github.com/mudassirsh/3-Tier-Flask-App/assets/18271814/4482e61c-2681-43d2-9f34-874c3489b38e" />

<br><br>

- **Create Security Group for Public subnet with all inbound traffic open**
<br><br>

- **Create Security Group for private subnet traffic open from public security group only**


<p align="center">
  <img width="500" height="300" src="https://github.com/mudassirsh/3-Tier-Flask-App/assets/18271814/23467813-9374-45f9-8f83-ace97e67703a">
 
</p>


- **Create EC2 instance in Public Subnet**


<p align="center">
  <img width="860" height="200" src="https://github.com/mudassirsh/3-Tier-Flask-App/assets/18271814/724a220d-4e19-450a-868f-2a4c043a55ff">
</p>

<br><br>


- **Create RDS (Aurora Postgres)**

DB type = Aurora – postgres
Template = any (Prod , Dev/Test)
DB cluster name = flask-db	
Credentials = postgres
Master password = postgres

<p align="center">
  <img width="350" height="300" src="https://github.com/mudassirsh/3-Tier-Flask-App/assets/18271814/11a68fdb-ccca-4489-99b9-80a2deaa4410">
  <img width="350" height="400" src="https://github.com/mudassirsh/3-Tier-Flask-App/assets/18271814/8c00705c-153d-4b0e-b5bd-36b8ed5b4bce">
</p>


Attach default SG to RDS

<img width="850" height="150" src="https://github.com/mudassirsh/3-Tier-Flask-App/assets/18271814/cb0fb6c1-4fae-4c89-9656-e774e7e42df3" />

<br>
<br><br>




- **Create Secrets Manager**

<img align="right" width="350" height="350" src="https://github.com/mudassirsh/3-Tier-Flask-App/assets/18271814/bc8deff2-2ab4-4e58-9a2c-b1eb607ec99f" />


Go to 	Store a new secret
Select RDS
Username:	postgres
Password	postgress

Once created it will give us Secret ARN:



<br><br><br><br><br>




<br><br><br>


- **Create IM role having access to RDS Aurora**
    - Create user (RDSuser)
    - Attach policies		        
       -  AmazonRDSDataFullAccess
       - SecretsManagerReadWrite







