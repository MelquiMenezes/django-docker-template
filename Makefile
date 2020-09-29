
MAIN_CONTAINER = backend

# ======================
# Docker
# ======================

up:
	@docker-compose up -d

down:
	@docker-compose down

build:
	@docker-compose up -d --build

install: up
	@docker exec -it $(MAIN_CONTAINER) pip-compile --generate-hashes ./requirements/dev.in
	@docker exec -it $(MAIN_CONTAINER) pip-compile --generate-hashes ./requirements/prod.in
	@docker-compose up -d --build

bash: up
	docker exec -it $(MAIN_CONTAINER) bash


# ======================
# Django Commands
# ======================

run: up
	@docker exec -it $(MAIN_CONTAINER) python manage.py runserver 0:8000

collect: up
	@docker exec -it $(MAIN_CONTAINER) python manage.py collectstatic --no-input

makemigrations: up
	@docker exec -it $(MAIN_CONTAINER) python manage.py makemigrations

migrate: up
	@docker exec -it $(MAIN_CONTAINER) python manage.py migrate

startapp: up
	@docker exec -it $(MAIN_CONTAINER) python manage.py startapp $(name)


# ======================
# MISC
# ======================

# Change project name

changeproject: up
	@echo "changing project name from '$(oldname)' to '$(newname)'..."
	@mv $(oldname) $(newname)
	@docker exec $(MAIN_CONTAINER) sed -i 's/$(oldname).settings/$(newname).settings/g' /app/$(newname)/asgi.py
	@docker exec $(MAIN_CONTAINER) sed -i 's/$(oldname).settings/$(newname).settings/g' /app/$(newname)/wsgi.py
	@docker exec $(MAIN_CONTAINER) sed -i 's/$(oldname).urls/$(newname).urls/g' /app/$(newname)/settings.py
	@docker exec $(MAIN_CONTAINER) sed -i 's/$(oldname).wsgi/$(newname).wsgi/g' /app/$(newname)/settings.py
	@docker exec $(MAIN_CONTAINER) sed -i 's/$(oldname).settings/$(newname).settings/g' /app/manage.py
	@echo "done!"

# Run isort for auto sort python imports

isort:
	@docker exec $(MAIN_CONTAINER) isort **/*.py
	@echo "iSort applied!"

#  Run lint

lint:
	@docker exec $(MAIN_CONTAINER) flake8 .
	@echo "flake8 applied!"

# Run test

test: up
	@docker exec $(MAIN_CONTAINER) coverage run manage.py test
	@docker exec $(MAIN_CONTAINER) coverage report
	@docker exec $(MAIN_CONTAINER) coverage erase
