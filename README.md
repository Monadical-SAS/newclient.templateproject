To use this project template:

1. clone this repo, delete the `.git` folder, and rename it before pushing it as a new repo.
```bash
git clone https://github.com/Monadical-SAS/newclient.templateproject actualclientname.actualprojectname
cd actualclientname.actualprojectname
rm -Rf .git
git init
git remote add origin https://github.com/Monadical-SAS/actualclientname.actualprojectname
```

2. Everywhere you see `newclient` should be replaced by the client's name (all one word, all lowercase).  
```bash
for file in $(ag -l "newclient"); do
    sed -i "s/$newclient/actualclientname/g" "$file"
done
```
3. Everywhere you see `templateproject` should be replaced by the project's name (all one word, all lowercase).  
```bash
for file in $(ag -l "templateproject"); do
    sed -i "s/$templateproject/actualprojectname/g" "$file"
done
```
4. Rename any files containing `newlcient` or `tempalteproject`, e.g.
```bash
mv templateproject actualprojectname
mv etc/supervisor/templateproject.conf etc/supervisor/actualprojectname.conf
...
```

5. Put your Django code inside `./actualprojectname` (final result should be `./actualprojectname/manage.py`), and your frontend JS code inside `./actualprojectname/frontend` (final result should be `./actualprojectname/frontend/index.js`). Update the README thoroughly (and delete these instructions from the top), add your code to git, create your initial commit, and push!

```
for file in $(ag -l "templateproject"); do
    sed -i "s/$templateproject/actualprojectname/g" "$file"
done
```

---

# NewClient.TemplateProject

<one line description about the project and what it does here>

https://example.com/replace/with/link/to/project/homepage

<img src="https://user-images.githubusercontent.com/511499/110674382-d77cde00-819f-11eb-8dbc-2c97784d805b.png" width="550px"/>


#### Quick Links

- Local dev: http://localhost:5000
- Beta dev: https://beta.example.com
- Production: https://example.com

---

## Quickstart

First, make sure you have Docker installed https://docs.docker.com/get-docker/:
```bash
curl -fsSL https://get.docker.com | bash
docker --version
docker-compose --version
```

Then clone the codebase, run the initial migrations and start the dev server:
```bash
# clone the codebase and build the containers
git clone https://github.com/Monadical-SAS/newclient.templateprojec
cd newclient.templateprojec
docker-compose build --pull

# run the initial migrations and create an admin superuser
docker-compose run --rm django ./manage.py migrate
docker-compose run --rm django ./manage.py createsuperuser
docker-compose down

# start all the containers and open the dev server in your browser
docker-compose up
open http://localhost:5000
```

---

## Developer Documentation

### Common Tasks

#### Adding a node dependency

```bash
docker-compose exec node npm install PACKAGE_NAME
docker-compose build node

docker-compose down
docker-compose up
```

#### Troubleshooting containers

```bash
# like htop but for docker containers
ctop

# to open a shell in a runing container use exec or run:
docker-compose ps
docker-compose exec node /bin/bash

docker-compose run --rm django ./manage.py shell
...
```

#### Create and run migrations

```bash
# create any migrations needed
docker-compose run --rm django ./manage.py makemigrations

# run the migrations
docker-compose run --rm django ./manage.py migrate
```

#### Create an admin supersuer

```bash
docker-compose run --rm django ./manage.py createsuperuser USERNAME

# or to update an existing user's password
docker-compose run --rm django ./manage.py changepassword USERNAME
```

#### Run linters and typecheckers

```bash
flake8 projectname
mypy projectname
```

### Run tests and calculate coverage

```bash
# run the tests without coverage report
pytest

# run the tests and generate coverage report in HTML
coverage run -m pytest
coverage html
open htmlcov/index.html
```

---

## Production Documentation

### Common Tasks

#### SSH into the server

```bash
ssh -p 44 root@<prod server hostname>
cd /opt/newclient.templateproject
```

#### Check the server logs

```bash
tail -n 100 -f /opt/newclient.templateproject/data/logs/docker.{err,out}
```

#### Deploy new changes to the server

```bash
# first, SSH into the server, then run these commands
cd /opt/newclient.templateproject

# stop the running server
supervisorctl stop newclient.templateproject
docker-compose down

# pull codebase changes and apply migrations
git checkout dev
git pull
docker-compose run --rm django ./manage.py migrate
docker-compose run --rm django ./manage.py createsuperuser   # only if needed

# make sure everything is in a fully stopped state correctly before starting anything
docker-compose down
docker-compose down  # yes, running it twice is necessary (once to stop running containers, once to clear old network + stopped containers)

# start the server again
supervisorctl start newclient.templateproject
# dont use docker-compose up as it will conflict with supervisord
```

#### Start/Stop/Check any running services

```bash
supervisorctl status newclient.templateproject
docker-compose ps
ctop                              # like htop but for docker containers

# stop the running server
supervisorctl stop newclient.templateproject
docker-compose down

# start the server again
# dont use docker-compose up as it will conflict with supervisord
supervisorctl start newclient.templateproject
```

#### Setup a new production server

<details>
<summary><b>Click to expand full instructions...</b></summary>

```bash
# Setup production server base system
apt update -qq; apt upgrade -y; apt install tmux fish; apt autoremove -y
mkdir -p ~/.config/fish
nano ~/.config/fish/config.fish  # get this file contents from nick
fish
setup_minimal     # (note: this changes SSH port from 22 to 44)
reboot

# Setup Docker https://docs.docker.com/get-docker/
curl -fsSL https://get.docker.com | bash

# Setup the codebasse
cd /opt
git clone https://github.com/Monadical-SAS/newclient.templateproject
cd newclient.templateproject
mkdir -p data/logs

# Setup Argo cert for ingress via Cloudflare
open https://www.cloudflare.com/a/warp
# download a cert for zervice.io into /opt/zohuddle.matchmaker/data/argo/cert.pem
# pick a clientname-projectname.zervice.io domain and put it in the argo command: in docker-compose.yml

# Setup the supervisord config and start the service
ln -s /opt/newclient.templateproject/etc/supervisor/*.conf /etc/supervisor/conf.d/
supervisorctl reread
supervisorctl update
supervisorctl start newclient.templateproject

# Run the inital migrations and create a superuser
docker-compose run --rm django ./manage.py migrate
docker-compose run --rm django ./manage.py createsuperuser

# Now it should be up and accessible on your configured argo domain
open https://clientname-projectname.zervice.io

# To troubleshoot, check the logs:
tail -n 100 -f /opt/newclient.templateproject/data/logs/docker.log
```

</details>

### 3rd-Party Services

#### DigitalOcean

Put any info here about servers used, and link to the droplets here.

https://cloud.digitalocean.com/droplets/123456/

#### Cloudflare

Used for DNS, SSL, Firewall, Caching, and ingress tunnel.

https://dash.cloudflare.com/413ad3842c5a82a780b582d8de8dc903/example.com
