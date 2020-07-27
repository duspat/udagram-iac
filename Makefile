# Webapp Deployment orchestration

# ##################
# Deploy Networking
# ##################
deploy-networking:
	@cd scripts && \
	. ./parameters/network.env && \
	./deploy-vpc-network.sh

# ###############
# Deploy Web App
# ###############
deploy-web-app:
	@cd scripts && \
	. ./parameters/web-app.env && \
	./deploy-web-app.sh

# ########
# Jumpbox
# ########
deploy-jumpbox:
	@cd scripts && \
	. ./parameters/jumpbox.env && \
	./deploy-jumpbox.sh

deploy-jumpbox-key:
	@cd scripts && \
	. ./parameters/jumpbox.env && \
	./import-key-pair.sh