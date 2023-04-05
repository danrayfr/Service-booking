# Ruby on Rails Service Booking web application

First assessment in my internship journey with ChatGenie.

## Before you Get started

Here are the following version of Ruby on Rails I'm using when doing this project.

```
$ gem -v 3.4.1
$ bundler -v 2.4.1
$ ruby -v 3.2.0
$ rails -v 7.0.4.2
```

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ gem install bundler -v 2.4.1
$ bundle _2.4.1_ config set --local without 'production'
$ bundle _2.4.1_ install
```

Create the database :

```
$ rails db:create
```

Next, migrate the database:

```
$ rails db:migrate

$ rails db:seed # optional
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

.