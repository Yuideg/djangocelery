dev:
	sudo docker-compose run app sh -c "python3 manage.py runserver"

makemigrations:
	sudo docker-compose run app sh -c "python3 manage.py makemigrations"
migrate:
	sudo docker-compose run app sh -c "python3 manage.py migrate"
up:
	sudo docker-compose up --remove-orphans

superuser:
	sudo docker-compose run --rm app  sh -c "python manage.py createsuperuser"
newapp:
	sudo docker-compose run app sh -c "python3 manage.py startapp semisters "