#!/bin/bash

terraform init
until [ $n = "q" ]
do
    read -r -p "Enter Terraform Command- I, P, A, D, or Q: " n
    case $n in
        "i" )
            terraform init -upgrade;;
        "p" )
            terraform plan --out=./plan.out;;
        "a" )
            if test -f "./plan.out"; then
                terraform apply "./plan.out"
            else
                echo "No plan file, run plan first!"
            fi;;
        "d" )
            read -r -p "Ready to destroy [yN] " d
            if [ $d = 'y' ]; then
                terraform destroy --auto-approve
                rm ./plan.out
            else
                echo "Not ready, no destroy!"
            fi;;
        * ) 
            echo "the choices are 'Initialize', 'Plan', 'Apply', 'Destroy', or 'Quit'..." ;;
    esac
done
echo "All done!"
