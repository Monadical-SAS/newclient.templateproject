<!------------ DELETE THESE INSTRUCTIONS WHEN FINISHED SETTING UP YOUR PROJECT ---------------------->

**Please use this project template for all new Monadical projects (both internal and client-facing)!**

1. clone this repo into `actualclientname.actualprojectname`, and setup a new Github repo as the origin
```bash
# project dir should be named clientname.projectname
# (client name and projectname should each be a single one word, all lowercase, no dashes or underscores)
#  e.g. zohuddle.matchmaker, pushforward.homenet, oddslingers.poker,  monadical.www, etc.
git clone https://github.com/Monadical-SAS/newclient.templateproject actualclientname.actualprojectname
cd actualclientname.actualprojectname

# create the new repo on github as a private/pubic repo under Monadical-SAS or Monadical-Inc first
git remote rm origin
git remote add origin https://github.com/Monadical-SAS/actualclientname.actualprojectname
```

2. Everywhere you see `newclient` should be replaced by the client's name (all one word, all lowercase).
```bash
for file in $(ag -l "newclient"); do
    sed -i "s/newclient/actualclientname/g" "$file"
done
```
Everywhere you see `templateproject` should be replaced by the project's name (all one word, all lowercase).  
```bash
for file in $(ag -l "templateproject"); do
    sed -i "s/templateproject/actualprojectname/g" "$file"
done
```
Rename any filenames containing `newlcient` or `tempalteproject` as well, e.g.
```bash
mv templateproject actualprojectname
mv etc/supervisor/templateproject.conf etc/supervisor/actualprojectname.conf
...
```

3. Put your Django apps inside `./actualprojectname` (e.g. `./actualprojectname/core/models.py`), and your frontend JS code inside `./actualprojectname/frontend` (e.g.`./actualprojectname/frontend/components/somebutton.js`). Update the README thoroughly (and delete these instructions from the top), add your code to git, create your initial commit, and push!
```bash
git add .
git push --set-upstream origin main main
```

4. Next steps: these are only recommendations, you can set any/all/none of these up however you see fit.

*Python Setup Recommendations:*

- Use Django w/ PostgreSQL or SQLite for database
- Setup `pipenv`, `mypy`, `black`, `flake8`, and `pytest` for packaging, typechecking, linting, and testing
- tried and true time-savers:
  - Use the Django admin as much as possible
  - Use [`python-decouple`](https://github.com/henriquebastos/python-decouple/) or ?????? [`django-environ`](https://github.com/joke2k/django-environ) to load your `settings.py` + `.env` config
  - Use [`django-import-export`](https://django-import-export.readthedocs.io/en/latest/) to get CSV/JSON/Excel import/export out of the box in the Django Admin
  - Use [`django-rest-framework`](https://www.django-rest-framework.org/) to build API endpoints
  - Use [`django-allauth`](https://github.com/pennersr/django-allauth) for managing authentication and [`django-anymail`](https://github.com/anymail/django-anymail) to handle sending emails via Mailgun
  - Use [`django-debug-toolbar`](https://django-debug-toolbar.readthedocs.io/en/latest/) for debugging and ?????? [`djdt-flamegraph`](https://github.com/23andMe/djdt-flamegraph) for profiling code performance
  

*JavaScript Setup Recommendations:*

- Use `Next.JS` + `React` w/ typescript for the frontend: https://nextjs.org/learn/excel/typescript
- Setup `yarn`, `eslint`, `prettier`, `typescript`, and `jest` for packaging, linting, typechecking, and testing
- tried and true time-savers:
  - don't use `create-react-app` or roll your own build system with webpack, stick to Next.js!
  - Use ?????? [`react-bootsrap`](https://react-bootstrap.github.io/) or [`material-ui`](https://github.com/mui-org/material-ui) to save time building UI layout
  - use ?????? [`date-fns`](https://date-fns.org/) for handling datetimes (not `moment.js`!)
  - Use a pre-built component library to save time building UI components & forms, e.g.:
    - ?????? https://formik.org/
    - ?????? https://github.com/ant-design/ant-design
    - https://blueprintjs.com/docs/#core
    - https://evergreen.segment.com/components/

*Hosting Setup Recommendations:*

- Use DigitalOcean for hosting your VPS (w/ managed PostgreSQL / Redis for production-critical deployemnts)
- Use CloudFlare for DNS, SSL, and ingress with Argo tunnels
- Use Mailgun and Twilio for email/sms/call sending
- Use Sentry for error tracking and tracing, and Matomo for analytics (https://analytics.zervice.io)
- Use Snapshooter to automate DigitalOcean backups https://snapshooter.io/

---

<!------------ DELETE FROM HERE UP WHEN FINISHED SETTING UP YOUR PROJECT ---------------------->

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
