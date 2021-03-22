terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.31.0"
    }
    snowflake = {
      source  = "chanzuckerberg/snowflake"
      version = "0.23.2"
    }
    time = {
      source = "hashicorp/time"
      version = "0.7.0"
    }
  }

  backend "s3" {
    key     = "snowflake_aws.tfstate"
    region  = "eu-central-1"
    bucket  = "asaintsever-lab"
    profile = "lab"
  }
}


provider "snowflake" {

}

locals { 
  snowflake = {
    test_db = "ALS_TEST"
    test_schema = "TEST"
  }
}

//--- Snowflake DB & Schema

resource "snowflake_database" "test_db" {
  name = local.snowflake.test_db
}

resource "snowflake_schema" "test_schema" {
  name     = local.snowflake.test_schema
  database = snowflake_database.test_db.name
}
