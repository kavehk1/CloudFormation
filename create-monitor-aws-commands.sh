#create a stack:
aws cloudformation create-stack \
--stack-name myStack \
--template-body file://template1.yaml \
--capabilities CAPABILITY_NAMED_IAM \
--parameters ParameterKey=KeyName,ParameterValue=vockey

#heck the status of each resource that is created by stack
watch -n 5 -d \
aws cloudformation describe-stack-resources \
--stack-name myStack \
--query 'StackResources[*].[ResourceType,ResourceStatus]' \
--output table

#check stack status 
watch -n 5 -d \
aws cloudformation describe-stacks \
--stack-name myStack \
--output table

#query that returns only the CREATE_FAILED events
aws cloudformation describe-stack-events \
--stack-name myStack \
--query "StackEvents[?ResourceStatus == 'CREATE_FAILED']"

#Delete  stack 
aws cloudformation delete-stack --stack-name myStack

#create stack with  no rollback on failure
aws cloudformation create-stack \
--stack-name myStack \
--template-body file://template1.yaml \
--capabilities CAPABILITY_NAMED_IAM \
--on-failure DO_NOTHING \
--parameters ParameterKey=KeyName,ParameterValue=vockey

#drift detection on  stack
aws cloudformation detect-stack-drift --stack-name myStack
aws cloudformation describe-stack-drift-detection-status --stack-drift-detection-id driftId

aws cloudformation describe-stack-resource-drifts --stack-name myStack
or
aws cloudformation describe-stack-resources \
--stack-name myStack \
--query 'StackResources[*].[ResourceType,ResourceStatus,DriftInformation.StackResourceDriftStatus]' \
--output table

aws cloudformation describe-stack-resource-drifts \
--stack-name myStack \
--stack-resource-drift-status-filters MODIFIED

#update stack
aws cloudformation update-stack \
--stack-name myStack \
--template-body file://template1.yaml \
--parameters ParameterKey=KeyName,ParameterValue=vockey

#get the Logical IDs of resources in an AWS CloudFormation stack
aws cloudformation describe-stack-resources --stack-name myStack

aws cloudformation describe-stack-resources --stack-name myStack --query 'StackResources[*].[ResourceType,LogicalResourceId]'

aws cloudformation describe-stack-resources --stack-name lab192stack --query "StackResources[*].[ResourceType,LogicalResourceId,Tags[?Key=='Name'].Value | [0]]"
