If ((Read-Host "Ready to start [y/N]") -eq "y") {
    # Read the contents of the secrets file
    # $secretsFile = "secrets.txt"
    # $secretsContent = Get-Content -Path $secretsFile

    # Set the value as an environment variable for this session
    # $env:ARM_ACCESS_KEY = $secretsContent
    $env:ARM_ACCESS_KEY = $(az keyvault secret show --name TF-stateStorage --vault-name TF-stateStorage --query value -o tsv)
    terraform init -input=false -backend-config="access_key=$env:ARM_ACCESS_KEY"

    $varFile = Read-Host "Path\Name of var-file, or blank if none"
    do {
        $response = Read-Host “Press I, F, V, P, A, D, or Q”
        switch ($response.ToLower()) {
            "i" {
                Write-Output "Initializing (again?)..."
                terraform init -backend-config="access_key=$env:ARM_ACCESS_KEY"
            }
            "p" {
                Write-Output "Running plan..."
                if ([string]::IsNullOrEmpty($varFile)) {
                    terraform plan -out plan.out
                }
                else {
                    terraform plan -var-file $varFile -out plan.out
                }
            }
            "a" {
                Write-Output "Applying plan..."
                if ([string]::IsNullOrEmpty($varFile)) {
                    terraform apply -auto-approve "plan.out"
                }
                elseif (Test-Path $varFile -PathType Leaf) {
                    terraform apply -var-file $varFile "plan.out"
                }
                else {
                    terraform apply -auto-approve
                }            
            }
            "d" {
                Write-Output "Planning destroy..."
                if ([string]::IsNullOrEmpty($varFile)) {
                    terraform plan -out plan.out -destroy
                }
                else {
                    terraform plan -out plan.out -var-file $varFile -destroy
                }
                if ((Read-Host "`u{1f622} ready to destroy [y/N]") -eq "y") {
                    Write-Output "Destroying..."
                    terraform apply "plan.out"
                }
            }
            "v" {
                Write-Output "Validating Terraform"
                terraform validate
            }
            "f" {
                Write-Output "Validating Terraform"
                terraform fmt
            }
            "q" {
                Write-Output "All done! `u{1f60e}"
                break
            }
            Default {
                Write-Output "`u{1f611} Didn't understand that, please try again"
                Write-Output "P = plan`nA = apply`nD = destroy (with verification)`nQ = quit"
            }
        }
    } until ($response -eq "q")
}  
else {
    Write-Output "Not ready, quitting script"
}