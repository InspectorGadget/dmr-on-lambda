# Docker Model Runner on AWS Lambda

This repository contains the code and configuration needed to deploy a Docker-based model runner on AWS Lambda. The model runner allows you to run machine learning models in a serverless environment, leveraging the scalability and cost-effectiveness of AWS Lambda.

## Features
- **Docker Support**: Run your models in Docker containers, ensuring consistency across different environments.
- **AWS Lambda Integration**: Seamlessly deploy and manage your model runner on AWS Lambda.
- **Scalability**: Automatically scale your model runner based on demand.
- **Cost-Effective**: Pay only for the compute time you consume.
- **Easy Deployment**: Simple deployment process using the `./deployer.sh` script. (Don't forget to change the parameters in the script to fit your needs!)

## Getting Started
To get started with the Docker Model Runner on AWS Lambda, follow these steps:
1. Clone the repository:
   ```bash
    git clone git@git@github.com:InspectorGadget/dmr-on-lambda.git
    cd dmr-on-lambda
    ```
2. Modify the `deployer.sh` script to set your AWS credentials, Lambda function name, and other parameters.
3. Run the deployment script:
    ```bash
    ./deployer.sh
    ```
4. Monitor the deployment process and verify that your model runner is successfully deployed on AWS Lambda.
5. Test the model runner by invoking the Lambda function with sample input data (Included in `test.http` file). - Be sure to change the URL to your deployed function!
6. Monitor the logs and performance of your model runner using AWS CloudWatch.