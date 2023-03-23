# README

## Description

Anyone who goes to a festival at least one time knows how difficult is to grab some drinks from the bars. They are crowded and sometimes queues are longer than the main artist we want to listen to!

That's why some promoters are developing an MVP for some new festivals. Bar counters where you can go and serve yourself a beer. This will help make the waiting time much faster, making festival attendees happier and concerts even more crowded, avoiding delays!

## MVP

The MVP consists of a rest api where you can create dispenser machines, open and close their tap and check their spending info.

## Requirements

Docker and docker-compose (v2) are required to run the project.

## Installation

1. Clone the repository
2. Run `docker compose up -d`

## Usage

The API is available at `http://localhost:3000`

## API

### Dispenser

#### Create dispenser

`POST /dispenser`

##### Request body

```json
{
	"flow_volume": 0.10324
}
```

##### Response

```json
{
	"id": 9,
	"flow_volume": "0.1032"
}
```

#### Open dispenser

`PUT /dispenser/:id/open`

##### Response

```json
{
	"status": "open",
	"updated_at": "2021-05-01T12:00:00Z"
}
```

#### Close dispenser

`PUT /dispenser/:id/close`

##### Response

```json
{
	"status": "close",
	"updated_at": "2021-05-01T12:00:00Z"
}
```

#### Dispenser spending info

`GET /dispenser/:id/spending`

##### Response

```json
{
	"amount": "0.2903",
	"usages_count": 1,
	"usages": [
		{
			"opened_at": "2023-03-23T21:55:25.445Z",
			"closed_at": "2023-03-23T21:55:28.258Z",
			"flow_volume": "0.1032",
			"total_spending": "0.2903"
		}
	]
}
```

## Tests

To run the tests, run `docker compose exec app bundle exec rspec`

## License

The api is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Contributing

Bug reports and pull requests are welcome on GitHub at [PullRequests](https://github.com/victoravellog/rviewer-beer-selfservice/pulls)

## Communication

If you have any questions, feel free to contact me at [@victoravellog](https://github.com/victoravellog)
