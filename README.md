# Nginx Deployment with Cloud Infrastructure

This project demonstrates the deployment of a website running Nginx, featuring a specific sentence on the homepage. The deployment involves creating Docker images, setting up cloud infrastructure with Terraform, implementing security measures, and automating the deployment process.

---

## Project Overview

The project was completed in the following stages:

1. **Docker Image Creation**: Used Docker to create an image with a custom `index.html` file and pushed it to Docker Hub.
2. **Cloud Infrastructure Setup**: Leveraged Terraform to build a secure and scalable cloud environment.
3. **Security Measures**: Implemented robust security mechanisms.
4. **Automation**: Used GitHub Actions for infrastructure automation.

---

## Stage 1: Docker Image Creation

- Created a custom `index.html` file with the required sentence for the website.
- Built a `Dockerfile` using an Nginx base image and overlaid it with the `index.html` file.
- Pushed the Docker image to Docker Hub for use in the cloud infrastructure.

---

## Stage 2: Infrastructure Setup

Utilized Terraform to create and manage the cloud environment, which includes the following modules:

### **1. VPC Module**
- Created a VPC with the necessary subnets and CIDR blocks.
- Configured a NAT Gateway to allow the private instance to pull the Docker image while remaining inaccessible from the internet.

### **2. EC2 Module**
- Created a private EC2 instance to host the Docker image and a Bastion Host for secure access.
- Used `remote exec` to:
  - Connect to the private instance via the Bastion Host.
  - Install Docker and run the container using `docker run`.

### **3. ALB (Application Load Balancer) Module**
- Configured an ALB to allow external users to access the private instance securely.
- Added SSL capabilities for enhanced security.
- Created a DNS record for a user-friendly website address.

---

## Security Measures

For security, I employed various mechanisms to create a secure environment and prevent unauthorized access:

- Configured a NAT Gateway to enable the private instance to download files from the internet while ensuring that it couldn't be accessed via its public IP of the NAT.
- Restricted access with tight **Security Group (SG)** rules:
  - Optionally, only allowed my IP address to access the Bastion Host for increased security.
- Set up a Certificate Authority (CA) for the website's DNS to ensure a secure and authenticated connection.

---

## Bonus Step: Automation with GitHub Actions

An optional bonus step was implemented, automating the entire process of deploying the infrastructure with a single Git push. This includes:

### Steps:
1. **Created Credentials**: Set up AWS credentials to allow access to my AWS account from GitHub Actions.
2. **Environment Variables and Secrets**:
   - Defined private keys, AWS Access Key, and Secret Access Key as repository secrets.
3. **Automation Process**:
   - Triggered automatically when pushing to the `main` branch.
   - Created a `tf.tfvars` file containing the environment variables.
   - The workflow steps include:
     - `terraform init`
     - `terraform plan -var-file=tf.tfvars`
     - `terraform apply -auto-approve -var-file=tf.tfvars`

---

## How to Run

You have two options to run the infrastructure: locally or automatically through GitHub Actions.

### **Option 1: Running Locally**

1. Clone the repository:
   ```bash
   git clone https://github.com/your-repository-name.git
   cd your-repository-name
   
2. Ensure Docker and Terraform are installed on your system.
3. To create the Docker image locally:
    ```bash
    docker build -t your-image-name .
    
4. To deploy the infrastructure with Terraform locally
    - Add a file tf.tfvars or any other file name and insert the necessary variables inside.
    - Then, initialize Terraform:
        ```bash
        terraform init 
    - Run `terraform plan` to preview the changes:
        ```bash
        terraform plan -var-file=tf.tfvars
    - Apply the changes to deploy the infrastructure:
        ```bash
        terraform apply -auto-approve -var-file=tf.tfvars
    
5. Or you can use the automation process I created in github action, all you need to do is enter the following changes and push the change and it will lift the infrastructure for you:  
    - secrets.AWS_ACCESS_KEY_ID
    - secrets.AWS_SECRET_ACCESS_KEY
    - secrets.EC2_PRIVATE_KEY
    - secrets.CERTIFICATE_ARN
    - vars.INSTANCE_TYPE
    - vars.PRIVATE_KEY_NAME
    - vars.AWS_REGION


**To enter the website copy this link :** https://ngnix.bargutman.click/
