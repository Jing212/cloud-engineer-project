# 1. 创建 VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# 2. 创建 Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# 3. 创建 Public Subnets
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = var.az_1
  map_public_ip_on_launch = true

  tags = { Name = "${var.project_name}-public-1" }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = var.az_2
  map_public_ip_on_launch = true

  tags = { Name = "${var.project_name}-public-2" }
}

# 4. 创建 Private App Subnets
resource "aws_subnet" "private_app_subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_app_subnet_1_cidr
  availability_zone = var.az_1

  tags = { Name = "${var.project_name}-private-app-1" }
}

resource "aws_subnet" "private_app_subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_app_subnet_2_cidr
  availability_zone = var.az_2

  tags = { Name = "${var.project_name}-private-app-2" }
}

# 5. 创建 Private DB Subnets
resource "aws_subnet" "private_db_subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_db_subnet_1_cidr
  availability_zone = var.az_1

  tags = { Name = "${var.project_name}-private-db-1" }
}

resource "aws_subnet" "private_db_subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_db_subnet_2_cidr
  availability_zone = var.az_2

  tags = { Name = "${var.project_name}-private-db-2" }
}

# --- NAT Gateway 配置 ---

# 1. 为 NAT Gateway 申请一个静态公网 IP (EIP)
resource "aws_eip" "nat" {
  domain = "vpc"
  tags   = { Name = "${var.project_name}-nat-eip" }
}

# 2. 在公有子网中创建 NAT Gateway
# 注意：NAT 必须放在 Public Subnet 才能通向互联网
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet_1.id # 放在其中一个公有子网即可

  tags = { Name = "${var.project_name}-nat-gw" }

  # 良好的习惯：确保 IGW 先创建好
  depends_on = [aws_internet_gateway.main]
}

# --- 路由表配置 ---

# 3. 为私有子网创建专用的路由表
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = { Name = "${var.project_name}-private-rt" }
}

# 4. 将路由表关联到所有的私有子网 (App 层和 DB 层)
resource "aws_route_table_association" "private_app_1" {
  subnet_id      = aws_subnet.private_app_subnet_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_app_2" {
  subnet_id      = aws_subnet.private_app_subnet_2.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_db_1" {
  subnet_id      = aws_subnet.private_db_subnet_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_db_2" {
  subnet_id      = aws_subnet.private_db_subnet_2.id
  route_table_id = aws_route_table.private.id
}