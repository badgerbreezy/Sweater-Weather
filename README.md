# <div align="center"> Sweater Weather - Mod 3 Final Project
![image](https://www.creativefabrica.com/wp-content/uploads/2019/05/Sweater-icon-by-hellopixelzstudio.png)
<!-- Shields -->
![](https://img.shields.io/badge/Rails-5.2.4-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a)
![](https://img.shields.io/badge/Ruby-2.5.3-orange)
![](https://img.shields.io/gem/figaro)
![](https://img.shields.io/gem/faraday)
![](https://img.shields.io/gem/fast_jsonapi)

## Table of Contents
  - [What it does](#what-it-does)
  - [Deployment Link](#deployment-link)
  - [Requirements](#requirements)
  - [How to Setup Sweater Weather](#how-to-setup-sweater-weather)
  - [API Contract](#api-contract)
  - [Testing](#testing)
  - [Learning Goals](#learning-goals)
  - [Contact](#contact)
  - [Acknowledgments](#acknowledgments)

## What it does

*Sweater Weather* is a Rails backend API based application that allows users to see the current weather and the forecasted weather at the destination. In addition, users can create a road trip between two destinations. *Sweater Weather* is built in a service-oriented architecture, designed for a frontend application to communicate with through an API. *Sweater Weather* exposes an API for a frontend application's requirements [which can be found here](https://backend.turing.io/module3/projects/sweater_weather/requirements).

## Deployment Link

[Backend server port 300](http://localhost:3000/)

## Requirements

 ### Dependencies
  * [figaro](https://github.com/laserlemon/figaro)
  * [faraday](https://github.com/lostisland/faraday)
  * [fast_jsonapi](https://github.com/Netflix/fast_jsonapi)
 ### Testing Dependencies
  * [rspec-rails](https://github.com/rspec/rspec-rails)
  * [simplecov](https://github.com/simplecov-ruby/simplecov)
  * [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)
  * [factory_bot_rails](https://github.com/thoughtbot/factory_bot)
  * [webmock](https://github.com/bblimke/webmock)
  * [VCR](https://github.com/vcr/vcr)
 ### Configurations
  * Ruby 2.5.3
  * Rails 5.2.4.4

## How to Setup Sweater Weather

1. Create a local folder
2. Fork and clone the repo into the local folder
3. Install gem packages: `bundle install`
4. Setup the database: `rails db:{drop,create,migrate}`
5. In CLI run `bundle exec figaro install`
6. Add the following to your `config/application.yml` file
  a. `MAPQUEST_API_KEY: <your mapquest api key>` [Mapquest API](https://developer.mapquest.com/documentation/)
  b. `OPEN_WEATHER_API_KEY: <your open weather map api key>` [Open Weather Map API](https://openweathermap.org/api/one-call-api)
  c. `BING_SEARCH_KEY: [your bing search api key]` [Bing Search API](https://www.microsoft.com/en-us/bing/apis/pricing)
7. Open one terminal window for rails-engine and run `rails s`
8. While the window is open, use an API testing tool like [Postman](https://www.postman.com/downloads/) to test the available endpoints.

## API Contract

To see an example response found below you can use [Postman](https://www.postman.com/downloads/):

#### Image Background

GET `/api/v1/backgrounds?location=<params>`

where params = an image search parameter

#### Forecast

GET `/api/v1/forecast?location=<params>`

where params = a city's location

#### User Registration

POST `/api/v1/users`

Send the following params as a JSON payload in the body - in Postman, under the address bar, click on “Body”, select “raw”, which will show a dropdown that probably says “Text” in it, choose “JSON” from the list

`{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}`

#### User Login

POST `/api/v1/sessions`

Send the following params as a JSON payload in the body - in Postman, under the address bar, click on “Body”, select “raw”, which will show a dropdown that probably says “Text” in it, choose “JSON” from the list

`{
  "email": "whatever@example.com",
  "password": "password"
}`

#### Road Trip

POST `/api/v1/road_trip`

Send the following params as a JSON payload in the body - in Postman, under the address bar, click on “Body”, select “raw”, which will show a dropdown that probably says “Text” in it, choose “JSON” from the list

`{
  "email": "whatever@example.com",
  "password": "password"
}`

Sample view of an API call in Postman:
![Road Trip](https://user-images.githubusercontent.com/67594471/105152199-1b1e6a00-5ac4-11eb-8d1a-c781ebec68ad.png)

## Testing

* RSpec is implemented for testing:

> RSpec is a tool for unit testing that will ensure there is intended functionality at each level of code.

1. In CLI run `bundle exec rspec install`
2. Run `rspec` from the CLI to see the test suite; there should be 53 passing tests

## Learning Goals

  * Expose an API that aggregates data from multiple external APIs

  * Expose an API that requires an authentication token

  * Expose an API for CRUD functionality

  * Determine completion criteria based on the needs of other developers

  * Research, select, and consume an API based on your needs as a developer

## Contact

#### Brian Liu: [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/brian-liu-8356287b/), [Email](mailto:brian.b.liu@gmail.com), [GitHub](https://github.com/badgerbreezy)

## Acknowledgments

Thank you to the Mod 3 Instructors Ian Douglas and Dione Wilson for instilling such a deep understanding of backend architecture and API consumption principles. Thank you for all of my 2008 BE classmates for technical and emotional support!

<!-- MARKDOWN LINKS -->
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
