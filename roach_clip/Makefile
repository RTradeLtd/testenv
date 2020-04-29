.PHONY: install
install:
	./scripts/install.sh

# used to start a single node for easy testing
# to start in insecure mode:
# env FLAGS=--insecure make single-node
.PHONY: single-node
single-node:
	cockroach start-single-node $(FLAGS)

.PHONY: start-testenv
start-testenv: cleanup gen-test-certs start-test-node setup-test-node

.PHONY: cleanup
cleanup:
	rm -rf certs cockroach-data safe-dir

# used to generate the required certificates for our test node
.PHONY: gen-test-certs
gen-test-certs:
	@echo generating certificate and key pairs
	mkdir certs && mkdir safe-dir
	./scripts/gen_certs.sh ca ./certs ./safe-dir/ca.key
	./scripts/gen_certs.sh node ./certs ./safe-dir/ca.key localhost
	./scripts/gen_certs.sh client ./certs ./safe-dir/ca.key temporal
	./scripts/gen_certs.sh client ./certs ./safe-dir/ca.key temporaladmin
	./scripts/gen_certs.sh client ./certs ./safe-dir/ca.key root
	./scripts/gen_certs.sh client ./certs ./safe-dir/ca.key dbadmin

# used to start our secure single-node test server
.PHONY: start-test-node
start-test-node:
	@echo starting single node
	cockroach \
		start-single-node \
		--certs-dir=certs \
		--listen-addr=localhost:5432 \
		--http-addr=localhost:8080 \
		--background

# stops the test node
.PHONY: stop-test-node
stop-test-node:
	cockroach \
		quit \
		--host=localhost:5432 \
		--certs-dir=certs

# setups the database after it starts
.PHONY: setup-test-node
setup-test-node:
	@echo creating database
	cockroach \
		sql \
		--certs-dir=certs \
		--user=root \
		--host=localhost:5432 \
		--execute="CREATE DATABASE temporal"
	@echo creating temporal database administrator
	cockroach \
		sql \
		--certs-dir=certs \
		--user=root \
		--host=localhost:5432 \
		--execute="CREATE USER temporaladmin WITH PASSWORD 'temporaladmin'"
	@echo creating general database administrator
	cockroach \
		sql \
		--certs-dir=certs \
		--user=root \
		--host=localhost:5432 \
		--execute="CREATE USER dbadmin WITH PASSWORD 'dbadmin'"
	@echo setting up user permissions
	cockroach \
		sql \
		--certs-dir=certs \
		--user=root \
		--host=localhost:5432 \
		--execute="GRANT ALL ON DATABASE temporal TO temporaladmin;"
	cockroach \
		sql \
		--certs-dir=certs \
		--user=root \
		--host=localhost:5432 \
		--execute="GRANT admin TO dbadmin;"

.PHONY: run-migrations
run-migrations:
	@echo running database migrations
	./scripts/run_migrations.sh
	temporal --config config.json migrate