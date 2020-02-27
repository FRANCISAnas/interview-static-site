# interview-static-site
A basic hello world website deployed to AWS (Done for an interview)

View the site here: http://will2bill-test-website.s3-website-eu-west-1.amazonaws.com/

### Requirments
- Website has text and an image
- Website is in AWS
- Tooling to set up application
- Provide & Document a mechanism for scaling the service/delivering to a wider audience
- Documentation on how to run the application plus deployment steps

## To Consider
- Monitoring
- Security
- Automation
- Network Diagrams

## To Do
- Work out correct ACL for public access
- Create deploy scripts
- Look into scalability
- Document terraform creation process

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

### Terraform
    Note: The Terraform state is stored in s3 and the bucket is not created within this code.
    Generally these buckets are shared across many projects, so storing it within this codebase would be unnecessary.

To build your application infrastructure run the following make commands:

To initialise your terraform state:

    make infrastructure_init  
    
To check if there are any changes that need applying

    make infrastructure_plan

To apply changes (or build the infrastructure from scratch)

    make infrastructure_apply