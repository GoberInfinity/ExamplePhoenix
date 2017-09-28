# ExamplePhoenix
A full JSON API using phoenix as backend, and a channel to view the new users in the database in real time.

## Introduction
To build this application I considered CORS which allows a web page to be requested from another domain outside the domain from which the resource originated, and for internal security the user's password will be kept in a hash; for the loading in real time I used the phoenix channel, which allowed me to add this features to the app.

## Prerequisities
* Install ["Elixir"](http://elixir-lang.org/install.html) <br />
* Install ["Phoenix"](http://www.phoenixframework.org/docs/installation) <br />
* Install ["Postresql"](https://www.postgresql.org/download/)

## Usage 
To use only in you local enviroment first clone this repository
1. First clone the repository: ```git clone https://github.com/GoberInfinity/ExamplePhoenix.git ```
2. Change to the new directory: ```cd ExamplePhoenix```
3. Create the database ```mix ecto.create``` (If you have an error here, check the database configuration at config/dev.exs) 
4. Install the dependences ```mix deps.get```
5. Finally run the local server ```mix phoenix.server```

## Deployment
Gets: You can get the json from the api typing:
``` bash
~ curl -H "Content-Type: application/json" https://otherpoolapi.herokuapp.com/api/persons 
~ curl -H "Content-Type: application/json" https://otherpoolapi.herokuapp.com/api/person_phones
~ curl -H "Content-Type: application/json" https://otherpoolapi.herokuapp.com/api/user_types
~ curl -H "Content-Type: application/json" https://otherpoolapi.herokuapp.com/api/userps
~ curl -H "Content-Type: application/json" https://otherpoolapi.herokuapp.com/api/sale_types
~ curl -H "Content-Type: application/json" https://otherpoolapi.herokuapp.com/api/saledetaills
```
Posts: You can post data from the api typing:
``` bash
~ curl -H "Content-Type: application/json" -X POST -d '{"person": {"first_name":"Armando","middle_name":"Lara","last_name":"Hernandez","email":"richar@google.com","age":21, "birthday":"1996-05-05"}}'  https://otherpoolapi.herokuapp.com/api/persons
~ curl -H "Content-Type: application/json" -X POST -d '{"person__phone": {"phone_number":320,"person_id":1}}' https://otherpoolapi.herokuapp.com/api/person_phones
~ curl -H "Content-Type: application/json" -X POST -d '{"user__type": {"name_type": "admin"}}' https://otherpoolapi.herokuapp.com/api/user_types
~ curl -H "Content-Type: application/json" -X POST -d '{"userp": {"password":"hola","person_id":1,"type_id":1}}' https://otherpoolapi.herokuapp.com/api/userps
~ curl -H "Content-Type: application/json" -X POST -d '{"sale__type": {"name_sale": "Event"}}' https://otherpoolapi.herokuapp.com/api/sale_types
~ curl -H "Content-Type: application/json" -X POST -d '{"saledetaill":{"order_date":"2017-05-05","due_date":"2017-05-06","subtotal":4000,"sale_type_id":1,"userp_id":2}}' https://otherpoolapi.herokuapp.com/api/saledetaills
```
Channel: To view the channel, go to : ```https://otherpoolapi.herokuapp.com/```, open the console and finally post a new person (only work for person model).

## Roadtrip
1. Modeled the database in paper.
2. Added the skeleton for deployment on Heroku.
3. Created the models and the urls for the api.
4. Added libraries for CORS, hashing and serializer.
5. Failed to make a post using a serializer.
6. Deleted serializer library.
5. Final deployment.

## Authors
* **Reyes Fragoso Roberto** - [Portfolio](http://robertoreyes.me)
