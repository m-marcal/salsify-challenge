# How to provision resources on AWS

1. **Prerequisites**: 

    * Docker CLI
    * AWS CLI (properly authenticated)
    * Terraform 
    * Gifmachine database url in the format: postgres://db_user:db_pass@db_addr:db_port/gifmachine

2. **Clone the Repository**: 

     ```bash
    git clone git@github.com:m-marcal/salsify-challenge.git
    ```

3. **Terraform Initialization**: 

    ```bash
    cd infra/
    terraform init 
    ```

4. **Deployment**:

    ```bash
    terraform plan # validate output
    terraform apply # make sure to pass the database url once asked
    ```

5. **Get ECR URL**

    ```bash
    terraform output # get the ECR Registry URL and update GitHub secrets
    ```