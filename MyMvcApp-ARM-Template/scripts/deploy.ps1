param(
    [string]$resourceGroupName = "MyResourceGroup",
    [string]$location = "East US",
    [string]$templateFile = "templates/azuredeploy.json",
    [string]$parameterFile = "templates/azuredeploy.parameters.json"
)

az group create --name $resourceGroupName --location $location

az deployment group create --resource-group $resourceGroupName --template-file $templateFile --parameters $parameterFile

Write-Host "Deployment completed successfully."