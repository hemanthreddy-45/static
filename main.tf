provider "aws" {
  region = "ap-south-1"  # Change this to your desired AWS region
}

# Create an S3 bucket for hosting the static website
resource "aws_s3_bucket" "website_bucket" {
  bucket = "demo-bucket"  # Replace this with your desired bucket name
         # Make the bucket content publicly readable
}

# Configure the website hosting for the S3 bucket
resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.website_bucket.bucket
 
}

# Fetch the index.html content from GitHub and upload it to the S3 bucket
data "http" "index_html" {
  url = "https://github.com/hemanthreddy-45/static/blob/main/index.html"
}

# Upload the HTML files to the S3 bucket
resource "aws_s3_object" "index_html_object" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  acl    = "public-read"
  content_type = "text/html"
  source = data.http.index_html.body_raw
}

# Output the website URL
output "website_url" {
  value = aws_s3_bucket.website_bucket.website_endpoint
}


