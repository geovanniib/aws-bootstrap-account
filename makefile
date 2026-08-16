
create:
	terraform init
	terraform apply -auto-approve
	terraform output -raw bucket_name > bucket_name.txt


clean:
	@if [ -f bucket_name.txt ]; then \
		BUCKET_NAME=$$(cat bucket_name.txt); \
		aws s3api list-object-versions --bucket "$$BUCKET_NAME" --query 'Versions[].{Key:Key,VersionId:VersionId}' --output text | while read -r KEY VERSION_ID; do \
			[ -n "$$KEY" ] && aws s3api delete-object --bucket "$$BUCKET_NAME" --key "$$KEY" --version-id "$$VERSION_ID" || true; \
		done; \
		aws s3api list-object-versions --bucket "$$BUCKET_NAME" --query 'DeleteMarkers[].{Key:Key,VersionId:VersionId}' --output text | while read -r KEY VERSION_ID; do \
			[ -n "$$KEY" ] && aws s3api delete-object --bucket "$$BUCKET_NAME" --key "$$KEY" --version-id "$$VERSION_ID" || true; \
		done; \
		aws s3 rb "s3://$$BUCKET_NAME" --force || true; \
	fi
	terraform destroy -auto-approve
	rm -f bucket_name.txt
	rm -f terraform.tfstate