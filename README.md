# Olympics API

## Introduction

The Olympics API provides analytical insight from the Rio 2016 Summer Olympics. This includes information about every olympian that competed, the youngest and oldest olympians, every sport and its events, and the medalists for each event.


## Initial Setup

Navigate into your desired directory and execute the following commands to set up the repository locally:

```
git clone git@github.com:johnktravers/olympics_api.git
cd olympics_api
bundle install
rake db:{create,migrate}
rake import:data
rails server
```

Once the commands have finished executing, open a web browser and navigate to http://localhost:3000. You can now access the API locally.


## Running Tests

To make sure the repository is set up correctly, run the test suite with the following command:

```
bundle exec rspec
```


## Endpoints

- #### `GET /api/v1/olympians`

This endpoint retrieves all of the olympians that competed in the 2016 games. No request body is necessary.

Response format:
```
{
  "olympians": [
    {
      "name": "Maha Abdalsalam",
      "team": "Egypt",
      "age": 18,
      "sport": "Diving"
      "total_medals_won": 0
    },
    {
      "name": "Ahmad Abughaush",
      "team": "Jordan",
      "age": 20,
      "sport": "Taekwondo"
      "total_medals_won": 1
    },
    {...}
  ]
}
```

- #### `GET /api/v1/olympians?age=youngest`

This endpoint gives back the youngest olympians that competed in the 2016 games. All olympians returned share the same age.

Response format:
```
{
  "olympians": [
    {
      "name": "Ana Iulia Dascl",
      "team": "Romania",
      "age": 13,
      "sport": "Swimming",
      "total_medals_won": 0
    }
  ]
}
```

- #### `GET /api/v1/olympians?age=oldest`

This endpoint gives back the oldest olympians that competed in the 2016 games. All olympians returned share the same age.

Response format:
```
{
  "olympians": [
    {
      "name": "Julie Brougham",
      "team": "New Zealand",
      "age": 62,
      "sport": "Equestrianism",
      "total_medals_won": 0
    }
  ]
}
```

- #### `GET /api/v1/olympian_stats`

This endpoint gives a set of statistics for all olympians that competed, including the total number of competitors, average weight (split by biological sex), and average age.

Response format:
```
{
  "olympian_stats": {
    "total_competing_olympians": 3120
    "average_weight:" {
      "unit": "kg",
      "male_olympians": 75.4,
      "female_olympians": 70.2
    },
    "average_age:" 26.2
  }
}
```

- #### `GET /api/v1/events`

- #### `GET /api/v1/events/:id/medalists`


## Database Schema

<img width="993" alt="olympics_api_schema" src="https://user-images.githubusercontent.com/46035439/75685086-3cc9f500-5c57-11ea-8cad-c854cadfdf2b.png">


## Tech Stack

- Ruby on Rails
- PostgreSQL
- RSpec
- Travis CI


## How to Contribute

If you would like to make a contribution, please fork the repo and set it up locally using the instructions above. Commit your changes, make a PR to this repo, and I'll get to it shortly. If you have any questions or advice for new features, feel free to reach out to me via my GitHub account below.


## Core Contributors

- [John Travers](https://github.com/johnktravers)
