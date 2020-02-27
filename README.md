# interview-static-site
A basic hello world website deployed to AWS (Done for an interview)

View the site here: http://will2bill-test-website.s3-website-eu-west-1.amazonaws.com/

Due to the scope of the project, a 'pretty' URL wasn't created for the resource, though this would normally be made
via Terraform. 

## Contents
1. [Requirements](#Requirements)
2. [Deploy Website](#Deploy Website)
3. [Terraform](#Terraform)
4. [Scalability](#Scalability)
5. [Monitoring and Alerts](#Monitoring and Alerts)
6. [Security](#Security)
7. [Automation](#Automation)

## Requirements
To work on and deploy the website you will need the following installed 
- GNU Make
- AWS CLI (with credentials for your AWS Account configured)

To build the website;s infrastructure you will need
- AWS CLI (with credentials for your AWS Account configured)
- Terraform

## Deploy Website
To deploy the site, run the following commands

    make deploy

This will sync the files in [src](src) with the s3 bucket. It will remove files that are on s3 but not in [src](src).
It will also print out the list of files currently on s3 so you can confirm the files you expect are there.

## Terraform
    Note: The Terraform state is stored in s3 and the bucket is not created within this code.
    Generally these buckets are shared across many projects, so storing it within this codebase would be unnecessary.

Due to the scope of the project only one environment is configured, you could easily create test and production
versions of the code using terraform workspaces and including ${terraform.workspace} as part of the 
name of the s3 bucket.

To build your application infrastructure run the following make commands:

To initialise your terraform state:

    make infrastructure_init  
    
To check if there are any changes that need applying

    make infrastructure_plan

To apply changes (or build the infrastructure from scratch)

    make infrastructure_apply

## Scalability
Amazon S3 largely scales automatically, preventing the need for much extra infrastructure to deliver the content to a
larger audience. There are some options however:

On the bucket, enable cross region replication guaranteeing the s3 site is closest to your users (good if they are from
a specific region).

[Distribute your site using CloudFront](https://docs.aws.amazon.com/AmazonS3/latest/dev/website-hosting-cloudfront-walkthrough.html),
This will allow you to make your website's files available from data centers everywhere so the website will always be
served from a source near your user. 
[You can find an example of how to configure cloudfront in Terraform here](https://www.terraform.io/docs/providers/aws/r/cloudfront_distribution.html).

## Monitoring and Alerts
You can configure the s3 bucket to include metrics like number and type of requests or 4xx errors. 
Details on the different metrics available are available 
[here](https://docs.aws.amazon.com/AmazonS3/latest/dev/cloudwatch-monitoring.html) and the configuration guide 
[here](https://docs.aws.amazon.com/AmazonS3/latest/dev/metrics-configurations.html). These resources can be terraformed,
see the docs [here](https://www.terraform.io/docs/providers/aws/r/s3_bucket_metric.html).

The metrics can also be hooked up to CloudWatch alarms for alerting purposes.  

Logging can also be configured, by adding the following code to the aws_s3_bucket resource in terraform:

    logging {
        target_bucket = data.aws_s3_bucket.logs
    }

## Security
Some level of security can be managed for AWS s3 buckets. You can limit access to specific files. Or turn off public
access and have your s3 bucket only accessible internally. What you can't easily do through a simple static site 
is making the resource both public and limited to specific users. For this you will need to move away from static
pages and move your website into something like ECS Fargate. 

## Automation
Automated deployments would be easy to set up in most ci/cd tools. Adding a single line of `make deploy` to a deploy
script is all that is necessary, possibly including `make infrastructure_plan` or similar to confirm the infrastructure
requires no changes. 

Due to the simplicity of the website used, there is no build step, so there's nothing to automate there, but a more
complex project could include testing the created site before moving onto the deploy steps. 

Once the build and deploy tasks are set up they can be automated (virtually every build tool is capable of this) to run
on whatever schedule you need. 