# Exam Pro


## Getting Started

The following steps walk through getting the application running. Before you start, please check out our [contributing guidelines].

1. [Clone the project](#1-clone-the-project)
2. [Install and set up the environment](#2-install-and-set-up-the-environment)
3. [Run the tests](#3-run-the-tests)
4. [Start the app](#4-start-the-app)

### 1. Clone the project

1. Navigate to your project's chosen parent directory, e.g. `cd ~/Desktop/CodeHall`
2. [Clone the project](https://help.github.com/articles/cloning-a-repository/), e.g. `https://github.com/alucard-alexander/exam_pro.git`
3. Navigate into the project directory: `cd exam_pro`



### 2. Install and set up the environment

# Installing Ruby/Postgres on your local environment

These are the original instructions for natively installing the app to your machine, using local installations of Ruby and Postgres.

## Contents
1. [Set up a Ruby Environment](#set-up-a-ruby-environment)
    - Option 1: using asdf
    - Option 1: Using rvm
    - Option 2: Using rbenv and ruby-build
2. [Install and run PostgreSQL](#install-and-run-postgresql)
    - Using Homebrew on a Mac
    - Using apt snap to install on linux debian flavoured
3. [Set up the database](#set-up-the-database)
    - Generate sample data

## Set up a Ruby Environment

You will need to install Ruby 2.4.2 using RVM or rbenv.


### Option 1: Using [asdf](https://gorails.com/setup/ubuntu/22.04#ruby)
```bash
asdf plugin add ruby
asdf install ruby 3.3.1
asdf global ruby 3.3.1

# Update to the latest Rubygems version
gem update --system
```

### Option 1: Using [rvm](https://rvm.io/rvm/install)

```bash
rvm install 3.3.0
```

### Option 2: Using [rbenv](https://github.com/sstephenson/rbenv) and [ruby-build](https://github.com/sstephenson/ruby-build)

```bash
rbenv install 3.3.0
rbenv global 3.3.0
```

## Install and run PostgreSQL

[The PostgreSQL Wiki has detailed installation guides](https://wiki.postgresql.org/wiki/Detailed_installation_guides) for various platforms, but probably the simplest and most common method for Mac users is with Homebrew:

### Using [Homebrew](https://brew.sh/) on a Mac

Note: You might need to install another build of Xcode Tools (typing `brew update` in the terminal will prompt you to update the Xcode build tools).

Install Postgres:
```bash
brew update
brew install postgresql
brew services start postgresql
```

Install the Gems:
```bash
gem install bundler
bundle install
```

### Using apt snap to install on linux debian flavoured
Install Postgres:
```bash
sudo apt install postgresql libpq-dev
```

To reset password:
```bash
sudo -u postgres createuser chris -s
# If you would like to set a password for the user, you can do the following
sudo -u postgres psql
postgres=# \password chris
```


## Set up the Database

Adjust `config/database.yml` as needed.

```bash
rails db:create
rails db:migrate db:test:prepare
```

*Note:* If you are running OSX Yosemite, you may experience a problem connecting to
Postgres. [This stackoverflow answer](http://stackoverflow.com/a/26458194/1510063) might help.

### Generate sample data

```bash
rails db:seed
```

#### Add your application details to your environment variables

##### Mac/Linux:
1. Run `touch .env` to create a file named `.env` in the root of the application folder.
2. Open this .env file in a text editor, and add details like :
```
DB_USERNAME=user
DB_PASSWORD=your_key
DB_HOST=database_host
DB_PORT=database_running_port
```

##### Windows:
Windows doesn't like creating a file named `.env`, so run the following
from a command prompt in your project folder:
```
echo DB_USERNAME=your_name >> .env
echo DB_PASSWORD=your_key >> .env
echo DB_HOST=database_host >> .env
echo DB_PORT=database_running_port >> .env
```

### 3. Run the tests

#### Running all the test cases
```bash
rspec spec
```

#### Running single tests/test files

If you just want to run a single test file you can pass the path to the file:
```bash
bundle exec rspec <path to test>
```

This can also be used with specific line number (running only that one test), for example:
```bash
bundle exec rspec <path to test>:line_number
```
### 4. Start the app

#### Run the below commands in the project folder
```bash
rails server
```

This should run a process which starts a server on your computer. This process won't finish - you'll know the server is ready when it stops doing anything and displays a message like this:
```
Rails 6.0.1 application starting in development on http://localhost:3000
```

**You can now view the app at http://localhost:3000**

You can stop the server when you're finished by typing `Ctrl + C`.


