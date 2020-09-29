# Django + Docker template project

This is a django + docker base project template

## Prerequisites

- Docker >= 19.0.0
- Make >= 3.0

## Usage

```sh

# Clone the repository
git clone https://github.com/gustavo-fonseca/django-docker-template YOUR_PROJECT_NAME

# Change the project name
cd ./YOUR_PROJECT_NAME
make changeproject oldname=base newname=YOUR_PROJECT_NAME

# Copy .env-template to .env
# Open the .env file and change the default data
cp .env-template .env

# Clean the git's origin
git remote remove origin

```


## Make commands from docker host machine
These commands shouldn't been run inside a container

```sh

# =============================
# Misc
# =============================

# Changing project name
make changeproject oldname=base newname=your_project_name

# Run lint
make lint

# Run isort
make isort


# =============================
# Docker
# =============================

# Shortcut: docker-compose up -d
make up

# Shortcut: docker-compose down 
make down

# Shortcut: docker-compose up -d --build 
make build

# Compile and install requirements && docker build
make install


# =============================
# Django
# =============================

# Shortcut: python manage.py runserver 0:8000
make run

# Shortcut: python manage.py collectstatic --no-input
make collect

# Shortcut: python manage.py makemigrations
make makemigrations

# Shortcut: python manage.py migrate
make migrate

# Shortcut: python manage.py startapp YOUR_APP_NAME
make startapp name=YOUR_APP_NAME

```