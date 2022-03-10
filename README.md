# Bugzilla
[Bugzilla.com](https://bugzilla2.herokuapp.com)

### Prerequisites
This project expects the following tools installed on your devise.
- Github
- Ruby [2.7](https://www.ruby-lang.org/en/news/2019/12/25/ruby-2-7-0-released/)
- Rails [5.2](https://guides.rubyonrails.org/5_2_release_notes.html)

## Install
### Clone the repository

```shell
git clone https://github.com/FaizAlii/Bugzilla.git
```
### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 2.5.1`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):

```shell
rbenv install 2.5.1
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler) and [Yarn](https://github.com/yarnpkg/yarn):

```shell
bundle && yarn
```
Using [Cloudinary](https://cloudinary.com) for uploading images on cloud.

You can see cloudinary config vars/keys on Dashboard or download the cloudinary.yml file directly.

### Set environment variables

Using [Figaro](https://github.com/laserlemon/figaro):

See [config/application.yml.sample](https://github.com/juliendargelos/project/blob/master/config/application.yml.sample).

Add ENV variables for [gmail](gmail.com) and [cloudinary](cloudinary.com) in application.yml

### Initialize the database

```shell
rails db:create db:migrate db:seed
```

### Install Gems

```shell
bundle install
```
### Server

```shell
rails s
```

## Deployment

### Deploy to Production on Heroku

Push to Heroku production remote:

```shell
git push heroku
heroku run rails db:create db:migrate db:seed
```

### Add ENV variables to heroku

#### Through Heroku Dashboard

Go to [Heroku Dashboard](https://dashboard.heroku.com)
Then go to Your App -> Settings -> Reveal Config Vars -> Add your ENV variables

#### Through CLI

##### Set an ENV variable

```shell
heroku config:set KEY=value
```

##### Remove an ENV variable

```shell
heroku config:unset KEY
```

That's it! You're good to go.
