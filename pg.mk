
GO_MOD = $(shell head -n 1 go.mod|sed "s/^module //g")
MOD_NAME = $(shell basename $(GO_MOD))
DB_BASE_URL ?= postgres://$(PG_USER):$(PG_PWD)@${PG_SERVICE}
export DB_URL = $(DB_BASE_URL)/$(MOD_NAME)?sslmode=disable
MIGRATION_PATH = data/migration
MIGRATE = @migrate -database "$(DB_URL)" -path $(MIGRATION_PATH)
CREATE_DB = 'create database "$(MOD_NAME)"'
DROP_DB = 'drop database if exists "$(MOD_NAME)"'

# Wait for postgres to be up
db.is-up:
	$(call _info,Waiting for Postgres…)
	@dockerize -wait tcp://$(PG_SERVICE):5432 -timeout 60s
.PHONY: db.is-up

# Reset database (rollback, migrate)
db.reset: db.is-up db.rollback db.migrate
.PHONY: db.reset

# Create database
db.create: db.is-up
	$(call _info,Creating DB $(MOD_NAME)…)
	@echo ">" $(CREATE_DB)
	@psql $(DB_BASE_URL) -c $(CREATE_DB)
.PHONY: db.create

# Drop database
db.drop: db.is-up
	$(call _info,Dropping DB $(MOD_NAME)…)
	@echo ">" $(DROP_DB)
	@psql $(DB_BASE_URL) -c $(DROP_DB)
.PHONY: db.drop

# Generate migration with NAME=<migration_name>
db.generate: db.is-up
	$(if $(NAME),,$(error NAME env var must be set to a migration name.))

	$(call _info,Generating DB $(MOD_NAME)…)
	$(MIGRATE) create -ext sql -dir $(MIGRATION_PATH) $(NAME)
	@find $(MIGRATION_PATH)/*$(NAME)* -newerct '1 second ago' -print
.PHONY: db.generate

# Apply all or N=<n> database migrations
db.migrate: db.is-up
	$(if $(N), \
		$(call _info,Running migrations up to $(N) on DB $(MOD_NAME)…), \
		$(call _info,Running all migrations on DB $(MOD_NAME)…) \
	)

	$(MIGRATE) up $(N)
.PHONY: db.migrate

# Rollback all or N=<n> database migrations
db.rollback: db.is-up
	$(if $(N), \
		$(call _info,Rolling back migrations down to $(N) on DB $(MOD_NAME)…), \
		$(call _info,Rolling back all migrations on DB $(MOD_NAME)…) \
	)

	$(MIGRATE) down $(N)
.PHONY: db.rollback

# Set migration version V=<v> without running migration
db.force: db.is-up
	$(if $(V),,$(error V env var must be set.))

	$(call _info,Force DB $(MOD_NAME) to migration $(V)…)
	$(MIGRATE) force $(V)
	$(MIGRATE) version
.PHONY: db.force

# Show current migration version
db.version: db.is-up
	$(call _info,$(MOD_NAME) DB version…)
	$(MIGRATE) version
.PHONY: db.version

ifdef SEED
# Seed database with SEED
db.seed: db.is-up
	$(call _info,Seeding DB $(MOD_NAME)…)
	@SVC_NAME=$(GO_MOD) DB_ENDPOINT=writer go run $(SEED)
.PHONY: db.seed
endif
