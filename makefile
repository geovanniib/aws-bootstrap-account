
create:
	terraform init
	terraform apply -auto-approve
	terraform output -raw bucket_name > bucket_name.txt


clean:
	terraform destroy -auto-approve
	rm -f bucket_name.txt
	rm -f terraform.tfstate