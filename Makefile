IPFSVERSION=v0.4.18
UNAME=$(shell uname)
INTERFACE=eth0
ADDR_NODE1=192.168.1.101
ADDR_NODE2=192.168.2.101
DOCKERCOMPOSE_TEST=env ADDR_NODE1=$(ADDR_NODE1) ADDR_NODE2=$(ADDR_NODE2) docker-compose

ifeq ($(UNAME), Darwin)
INTERFACE=en0
endif

# Set up test environment
.PHONY: testenv
WAIT=3
testenv:
	@echo "===================   preparing test env    ==================="
	@echo "Setting up network..."
	@sudo ip link set $(INTERFACE) up
	@sudo ip addr add $(ADDR_NODE1) dev $(INTERFACE)
	@sudo ip addr add $(ADDR_NODE2) dev $(INTERFACE)
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
	@echo "Cleaning network interfaces..."
	@sudo ip addr del $(ADDR_NODE1) dev $(INTERFACE)
	@sudo ip addr del $(ADDR_NODE2) dev $(INTERFACE)
	@echo "===================          done           ==================="
