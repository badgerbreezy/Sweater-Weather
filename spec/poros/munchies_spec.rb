require 'rails_helper'

describe Munchies, type: :poro do
  before :each do
    @trip_data = {
      :route=>{
        :formattedTime=>"03:21:41",
        :locations=>[
          {
            :street=>"",
            :adminArea5=>"Denver",
            :adminArea3=>"CO",
            :postalCode=>"",
            :latLng=> {
              "lng": -104.984853,
              "lat": 39.738453
            }
          },
          {
            :street=>"",
            :adminArea5=>"Aspen",
            :adminArea3=>"CO",
            :postalCode=>"",
            :latLng=> {
              "lng": -106.819201,
              "lat": 39.190665
            }
          }
        ]
      }
    }

    @restaurant_data = {
      :businesses=>[
        {
          :name=>"Bok Choy",
          :is_closed=>true,
          :location=>{
            :display_address=>[
              "308 S Hunter St", "Aspen, CO 81611"
              ]
            }
          },
        {
          :name=>"Jing Asian Fusion Sushi and Raw Bar",
          :is_closed=>false,
          :location=>{
             :display_address=>[
               "413 E Main St", "Aspen, CO 81611"
               ]
             }
           }
         ]
       }

    @munchies = Munchies.new(@restaurant_data, @trip_data)
  end

  it 'exists and has attributes' do
    expect(@munchies).to be_a(Munchies)
    expect(@munchies.id).to eq(nil)
    expect(@munchies.destination_city).to be_a(String)
    expect(@munchies.destination_city).to eq('Aspen, CO')
    expect(@munchies.travel_time).to be_a(String)
    expect(@munchies.travel_time).to eq('3 hours, 21 minutes')
    expect(@munchies.forecast).to be_a(Hash)
    expect(@munchies.forecast).to have_key(:temperature)
    expect(@munchies.forecast).to have_key(:summary)
    expect(@munchies.forecast[:temperature]).to be_a(Numeric)
    expect(@munchies.forecast[:summary]).to be_a(String)

    expect(@munchies.restaurant).to be_a(Hash)
    expect(@munchies.restaurant).to have_key(:name)
    expect(@munchies.restaurant).to have_key(:address)
    expect(@munchies.restaurant[:name]).to be_a(String)
    expect(@munchies.restaurant[:name]).to eq("Jing Asian Fusion Sushi and Raw Bar")
    expect(@munchies.restaurant[:address]).to be_a(String)
    expect(@munchies.restaurant[:address]).to eq("413 E Main St, Aspen, CO 81611")

    expect(@munchies.restaurant[:name]).to_not eq("Bok Choy")
  end

  it 'can format address' do
   expect(@munchies.convert_address(@trip_data[:route][:locations][1])).to eq('Aspen, CO')
 end

  it 'can convert time to array' do
    expect(@munchies.time_convert(@trip_data[:route][:formattedTime])).to eq(["3", "21"])
  end

  it 'can format time' do
    expect(@munchies.time_format(@trip_data[:route][:formattedTime])).to eq('3 hours, 21 minutes')
  end

  it 'can find weather at eta' do
    restaurant_data = {
      :businesses=>[
        {
          :name=>"whatever",
          :is_closed=>false,
          :location=>{
            :display_address=>[
              "la dee da", "NY"
              ]
            }
          }
        ]
      }

    trip_data = {
      :route=>{
        :formattedTime=>"40:34:31",
        :locations=>[
          {
            :street=>"",
            :adminArea5=>"New York",
            :adminArea3=>"NY",
            :postalCode=>"",
            :latLng=> {
              "lng": -74.007228,
              "lat": 40.713054
            }
          },
          {
            :street=>"",
            :adminArea5=>"Los Angeles",
            :adminArea3=>"CA",
            :postalCode=>"",
            :latLng=> {
              "lng": -118.243344,
              "lat": 34.052238
            }
          }
        ]
      }
    }
    munchies = Munchies.new(restaurant_data, trip_data)
    location = Hash[trip_data[:route][:locations][1][:latLng].sort]
    hourly_weather = WeatherService.get_weather_data(location)[:hourly]
    expect(munchies.eta_weather(trip_data)[:summary]).to eq(hourly_weather[40][:weather][0][:description])
    expect(munchies.eta_weather(trip_data)[:temperature]).to eq(hourly_weather[40][:temp])
  end
end
