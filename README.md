# Generic Instructions


Here are the step-by-step instructions to achieve the desired result using Terraform and Docker:

### Step-by-Step Instructions

#### Prerequisites
1. *AWS Account*: Ensure you have an AWS account with appropriate permissions to create EC2, RDS, and S3 resources.
2. *AWS CLI*: Install and configure the AWS CLI with your credentials.
3. *Terraform*: Install Terraform on your local machine.
4. *SSH Key Pair*: Create an SSH key pair for accessing the EC2 instance.
5. *Docker Hub Account*: Create a Docker Hub account to store your Docker image.

#### Step 1: Set Up Terraform Configuration Files

1. *Create a new directory for your project*:
    bash
    mkdir terraform-aws-project
    cd terraform-aws-project
    

2. *Create main.tf for basic infrastructure setup*:
   

3. *Create backend.tf for remote state management*:
    hcl
        systemctl enable httpd"s3" {
        bucket         = "my-terraform-state-bucket"
        key            = "path/to/my/key"
        region         = "us-west-2"
        dynamodb_table = "terraform-lock"
      }
    }
    

#### Step 2: Docker Image Creation

1. *Create a Dockerfile* in a new directory:
   

2. *Build and push the Docker image* to Docker Hub:

    docker build -t mydockerhubaccount/mydockerimage .
    docker login
    docker push mydockerhubaccount/mydockerimage
    

#### Step 3: Configure EC2 to Run Docker

1. **Create `ec2_docker.tf`** to configure EC2 instance for Docker:
  
#### Step 4: Initialize and Apply Terraform Configuration

1. **Initialize Terraform**:

    terraform init
   

2. **Apply the Terraform configuration**:

    terraform apply
 

#### Step 5: Verify the Setup

1. **SSH into the EC2 instance**:

    ssh -i ~/.ssh/my-key.pem ec2-user@<EC2_PUBLIC_IP>
    

2. *Check if the Docker container is running*:
 
    docker ps
   

3. *Verify the web server* by accessing http://<EC2_PUBLIC_IP> in your browser. You should see the "Hello World" message.

### Justifications for Choices

- *EC2*: Offers flexibility for custom configurations and easy SSH access.
- *RDS PostgreSQL*: Provides managed database services with automatic backups, scaling, and maintenance.

### Additional Considerations

- *State File Management*: State files are stored in an S3 bucket with versioning enabled, and DynamoDB is used for state locking.
- *Lock File Management*: The .terraform.lock.hcl file ensures consistent provider versions across different runs.

### Access

- *Docker Image*: Share the Docker Hub repository link for the built image.
- *Terraform Files*: Share the GitHub repository or any version control system link for the Terraform files.

This should provide a comprehensive guide to set up the required infrastructure and Docker container on AWS using Terraform.
