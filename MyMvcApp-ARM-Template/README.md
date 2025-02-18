# MyMvcApp CRUD Application ARM Template

This repository contains an ARM template for deploying the MyMvcApp CRUD Application to Azure. The template defines the necessary resources and configurations required for the application to run in the Azure environment.

## Project Structure

- **templates/**: Contains the ARM template files.
  - **azuredeploy.json**: The main ARM template that defines the resources to be deployed.
  - **azuredeploy.parameters.json**: Parameters file for customizing the deployment.
  
- **scripts/**: Contains scripts for deployment.
  - **deploy.ps1**: PowerShell script to automate the deployment of the ARM template.

## Prerequisites

- Azure subscription
- Azure CLI or Azure PowerShell installed
- Appropriate permissions to create resources in the Azure subscription

## Deployment Instructions

1. Clone this repository to your local machine.
2. Open a terminal or PowerShell window.
3. Navigate to the directory containing the `deploy.ps1` script.
4. Run the script using the following command:
   ```powershell
   .\deploy.ps1
   ```
5. Follow the prompts to provide any required parameters for the deployment.

## Notes

- Ensure that you have configured your Azure CLI or PowerShell with the correct subscription context.
- Review the `azuredeploy.parameters.json` file to customize the deployment settings as needed.