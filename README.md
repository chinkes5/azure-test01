# azure-test01
initial testing to use Terraform with Azure. This is a copy, sort of, of what I made in the AWS terraform test repo. 

## Structure and Use
There are several terraform files to describe each kind of resource with a variable file to hold all the specific values used.

## Source Material
* [Starting with the Terraform example] (https://learn.hashicorp.com/tutorials/terraform/azure-build?in=terraform/azure-get-started)
* [Adding Terragrunt into the mix] (https://gaunacode.com/using-terragrunt-to-deploy-to-azure)
* [2hr YouTube video on making Azure stuff with Terraform] (https://www.youtube.com/watch?v=V53AHWun17s)

## Step 0
Things I had to do to get this so it would work-
1. Get Azure account
2. Install Azure CLI (the command is in terraform guide)
   - Login to your account with `az login`
   - Select the subscription to use with `az account set --subscription "name of subscription"`
   - --Select or create the [RBAC Service Principal] (https://developer.hashicorp.com/terraform/tutorials/azure-get-started/azure-build?in=terraform%2Fazure-get-started#create-a-service-principal) to allow Terraform to act on your behalf--
3. Make Key Vault to hold storage account key
   - Create a resource group: `az group create --name Terraform-StateFiles --location westus2`
   - Make the vault: `az keyvault create --location westus2 --name TF-stateStorage --resource-group Terraform-StateFiles`
   - Make the secret, using the secret key from the new vault: `az keyvault secret set --name TF-stateStorage --vault-name TF-stateStorage --value '<<secret value>>'`
4. Make a storage location to store state files
   - Create an Azure storage account: `az storage account create --name chinkesterraformstorage --resource-group Terraform-StateFiles --location westus2 --sku Standard_LRS`
   - Create a container within the storage account: `az storage container create --name statefiles --account-name Terraform-Storage --account-key <storage_account_access_key>`
   - You can read the `<storage_account_access_key>` and set it as an environment variable with this: `$env:ARM_ACCESS_KEY = $(az keyvault secret show --name TF-stateStorage --vault-name TF-stateStorage --query value -o tsv)`
   - When initalizing Terraform, use `-backend-config="access_key=$env:ARM_ACCESS_KEY"` option to pass in the `<storage_account_access_key>`

## Step 1
You will likely have to run the step 0.2 login stuff whenever you open this again.