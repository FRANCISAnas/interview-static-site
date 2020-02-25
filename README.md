# interview-static-site
A basic hello world website deployed to AWS (Done for an interview)

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

### Terraform
Note: The Terraform state is stored in s3 and the bucket is not created within this code.
Generally these buckets are shared across many projects, so storing it within this codebase would be unnecessary.