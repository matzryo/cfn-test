.PHONY: validate-template
validate-template:
	aws cloudformation validate-template --template-body file://./template.yml

.PHONY: create-stack
create-stack:
	aws cloudformation create-stack --template-body file://./template.yml --cli-input-json file://./cli-input.json

.PHONY: wait-create-stack
wait-create-stack:
	aws cloudformation wait stack-create-complete --stack-name cfn-test-stack

.PHONY: get-url
get-url:
	aws cloudformation describe-stacks --stack-name cfn-test-stack --query "Stacks[0].Outputs[0]"

.PHONY: deploy
deploy:
	aws cloudformation deploy --stack-name cfn-test-stack --template-file ./template.yml

.PHONY: delete
delete:
	aws cloudformation delete-stack --stack-name cfn-test-stack

.PHONY: ssh
ssh:
	ssh -i ~/.ssh/cfn-test-key.pem ec2-user@$(HOST)

# インスタンス内で
# /opt/aws/bin/cfn-init -v --stack cfn-test-stack --resource WebServerInstance --configsets InstallAndRun --region ap-northeast-1
