IPFSVERSION=v0.4.20
UNAME=$(shell uname)
DOCKERCOMPOSE_TEST=env docker-compose
LSBDESC=lsb_release -d | awk '{print $2}'

# Set up test environment
.PHONY: testenv
WAIT=3
testenv:
	@echo "===================   preparing test env    ==================="
	@echo "Spinning up test env components..."
	@echo "Run 'make clean' to update the images used in the test environment"
	@$(DOCKERCOMPOSE_TEST) up -d
	@sleep $(WAIT)
	@echo "Containers online:"
	@docker ps
	@echo "===================          done           ==================="

# Shut down testenv
.PHONY: stop-testenv
stop-testenv:
	@echo "===================  shutting down test env ==================="
	@$(DOCKERCOMPOSE_TEST) down
	@echo "===================          done           ==================="

# Remove assets
.PHONY: clean
clean: stop-testenv
	@echo "=================== cleaning up temp assets ==================="
	@echo "Removing Docker assets..."
	@$(DOCKERCOMPOSE_TEST) rm -f -v
	@echo "===================          done           ==================="
