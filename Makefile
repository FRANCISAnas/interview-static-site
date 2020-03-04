ORGANISATION=will2bill
SYSTEM_CODE=test-website
WEBSITE_FOLDER=src
S3_BUCKET=$(ORGANISATION)-$(SYSTEM_CODE)

deploy: send_files check_files

send_files:
	aws s3 sync $(WEBSITE_FOLDER) s3://$(S3_BUCKET) --delete

check_files:
	@echo Files on s3:
	@aws s3 ls $(S3_BUCKET) --recursive --human-readable --summarize

infrastructure_init:
	cd infrastructure; \
	terraform init

infrastructure_plan:
	cd infrastructure; \
	terraform plan

infrastructure_apply:
	cd infrastructure; \
	terraform apply