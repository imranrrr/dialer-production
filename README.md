# README #

This README would normally document whatever steps are necessary to get your application up and running.

### What is this repository for? ###

* Quick summary
* Version
* [Learn Markdown](https://bitbucket.org/tutorials/markdowndemo)

### How do I get set up? ###

* sudo apt-get update
* sudo apt-get install default-mysql-server default-mysql-client default-libmysqlclient-dev
* sudo mysql_upgrade
* sudo mysql_secure_installation
* gem install mysql2
* sudo apt install nodejs
* sudo apt install npm
* sudo npm install --global yarn
* cd dialer
* Run msql -u root
* CREATE USER user IDENTIFIED BY 'password';
* GRANT ALL PRIVILEGES  ON dialer_development.* TO user@localhost identified by 'password';
* GRANT ALL PRIVILEGES  ON dialer_test.* TO user@localhost identified by 'password';
* vi config/database.yml
* sudo rake db:create
* rails server --binding=server_public_IP
* Revert to clean DB rake db:migrate VERSION=0
### Contribution guidelines ###

* Writing tests
* Code review
* Other guidelines

### Who do I talk to? ###

* Repo owner or admin
* Other community or team contact