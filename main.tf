provider "aws" {
  region = "ap-south-1"  # Change this to your desired AWS region
}

# Create an S3 bucket for hosting the static website
resource "aws_s3_bucket" "website_bucket" {
  bucket = "demo-bucket-name"  # Replace this with your desired bucket name
  

  website {
    index_document = "index.html"      # Specify the main entry point of your website
    
  }
}

# Fetch the index.html content from GitHub and upload it to the S3 bucket
data "http" "index_html" {
  url = "https://github.com/hemanthreddy-45/static/blob/main/index.html"
}

# Upload the HTML file to the S3 bucket
resource "aws_s3_bucket_object" "website_object" {
  bucket = aws_s3_bucket.website_bucket.id
  key    = "index.html"
  acl    = "public-read"
  content_type = "text/html"
  source = data.http.index_html.body_raw
}

# Output the website URL
output "website_url" {
  value = aws_s3_bucket.website_bucket.website_endpoint
}
