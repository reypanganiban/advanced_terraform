## Input variables
- Input variables are used to generalize a configuration so that it can be used in a variety of scenarios. Terraform supports variables of several types, including a string, numerical values, a bool or boolean, lists and maps.
- Separating the variable declarations from the main configuration items in main.tf makes it easier to find elements of the configuration. Terraform will combine all files with a .tf extension into the root module of the configuration.

## Tree methods to define variables 
- using terraform.tfvars file. https://github.com/reypanganiban/advanced_terraform/blob/my_branch/terraform.tfvars
- command line options. 
```terraform plan -out s1.tfplan -var="project-id=rp-learning-gcp"```
- environment variables.