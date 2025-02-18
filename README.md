# MyMvcApp CRUD Application

This repository contains the MyMvcApp CRUD Application along with the necessary ARM template and GitHub Actions workflow for deploying the application to Azure.

## Project Structure

- **MyMvcApp-ARM-Template/**: Contains the ARM template files for deploying the application to Azure.
  - **templates/**: Contains the ARM template and parameters files.
    - **deploy.json**: The main ARM template that defines the resources to be deployed.
    - **deploy.parameters.json**: Parameters file for customizing the deployment.
  - **scripts/**: Contains scripts for deployment.
    - **deploy.ps1**: PowerShell script to automate the deployment of the ARM template.

- **.github/workflows/**: Contains the GitHub Actions workflow file for continuous deployment.
  - **azure-webapp-deploy.yml**: GitHub Actions workflow file for building and deploying the application to Azure.

## Prerequisites

- Azure subscription
- Azure CLI or Azure PowerShell installed
- Appropriate permissions to create resources in the Azure subscription
- GitHub account
- GitHub repository with the application code

## Deployment Instructions

### Step 1: Create Azure Resources

1. **Navigate to the Azure Portal**:
   - Open your web browser and go to [https://portal.azure.com](https://portal.azure.com).

2. **Create a New Resource**:
   - In the Azure Portal, click on the "Create a resource" button in the left-hand menu.
   - Search for "Web App" and select "Web App" from the search results.
   - Click on the "Create" button to start the Web App creation process.
   - Fill in the required details:
     - **Subscription**: Select your Azure subscription.
     - **Resource Group**: Select an existing resource group or create a new one.
     - **Name**: Enter a unique name for your Web App (e.g., `myMvcApp`).
     - **Publish**: Select "Code".
     - **Runtime stack**: Select ".NET 8".
     - **Operating System**: Select "Windows" or "Linux" based on your preference.
     - **Region**: Select the region where you want to host your Web App.
     - **App Service Plan**: Select an existing App Service Plan or create a new one (e.g., `myAppServicePlan`).
   - Click on the "Review + create" button and then click on the "Create" button to create the Web App.

### Step 2: Set Up Deployment Center

1. **Open Deployment Center**:
   - In the Azure Portal, navigate to your newly created Web App.
   - In the left-hand menu, scroll down to the "Deployment" section and click on "Deployment Center".

2. **Configure GitHub Actions**:
   - In the Deployment Center, select "GitHub" as the source.
   - Authenticate with your GitHub account if prompted.
   - Select your GitHub repository (`MyMvcApp-Contact-Database-Application`) and the branch you want to deploy from (e.g., `master`).
   - Select "GitHub Actions" as the build provider.
   - Click on "Next" and follow the prompts to set up the deployment pipeline.

### Step 3: Create GitHub Actions Workflow

1. **Create the Workflow Directory**:
   - In your local repository, create a directory named `.github` if it doesn't already exist.
   - Inside the `.github` directory, create another directory named `workflows`.

2. **Create the Workflow File**:
   - Inside the `workflows` directory, create a file named `azure-webapp-deploy.yml`.

3. **Add the Workflow Content**:
   - Open the `azure-webapp-deploy.yml` file in a text editor and add the following content:

```yaml
name: Deploy MyMvcApp to Azure Web App

on:
  push:
    branches:
      - master

jobs:
  build-and-deploy:
    runs-on: windows-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Set up .NET Core
      uses: actions/setup-dotnet@v1
      with:
        dotnet-version: '8.0.x'

    - name: Restore dependencies
      run: dotnet restore

    - name: Build
      run: dotnet build --configuration Release --no-restore

    - name: Publish
      run: dotnet publish --configuration Release --output D:\a\MyMvcApp-Contact-Database-Application\MyMvcApp-Contact-Database-Application\bin\Release\net8.0\MyMvcApp --no-build

    - name: Upload artifact for deployment job
      uses: actions/upload-artifact@v2
      with:
        name: dotnet-app
        path: D:\a\MyMvcApp-Contact-Database-Application\MyMvcApp-Contact-Database-Application\bin\Release\net8.0\MyMvcApp

    - name: Deploy to Azure Web App
      uses: azure/webapps-deploy@v2
      with:
        app-name: 'myMvcApp' # Replace with your Azure Web App name
        slot-name: 'production'
        publish-profile: ${{ secrets.AZURE_WEBAPP_PUBLISH_PROFILE }}
        package: D:\a\MyMvcApp-Contact-Database-Application\MyMvcApp-Contact-Database-Application\bin\Release\net8.0\MyMvcApp