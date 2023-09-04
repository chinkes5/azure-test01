If ((Read-Host "Ready to start [y/N]") -eq "y") {
    # Read the contents of the secrets file
    $secretsFile = "secrets.txt"
    $secretsContent = Get-Content -Path $secretsFile

    # Set the value as an environment variable for this session
    $env:ARM_ACCESS_KEY = $secretsContent
    terraform init -input=false -backend-config="access_key=$env:ARM_ACCESS_KEY"

    $varFile = Read-Host "Path\Name of var-file, or blank if none"
    do {
        $response = Read-Host “Press I, F, V, P, A, D, or Q”
        switch ($response.ToLower()) {
            "i" {
                Write-Output "Initiallizing (again?)..."
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
                    terraform apply "plan.out"
                }
                else {
                    terraform apply -var-file $varFile "plan.out"
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
                if ((Read-Host "`u{1f622} ready to destroy [y/n]") -eq "y") {
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
                Write-Output "`u{1f611} Didn't undestand that, please try again"
                Write-Output "P = plan`nA = apply`nD = destroy (with verification)`nQ = quit"
            }
        }
    } until ($response -eq "q")
}  
else {
    Write-Output "Not ready, quitting script"
}