require 'rubygems'
require 'sinatra'
require 'simpler_tiles'
require 'yaml'

# Set up the tile url to capture x, y, z coordinates for slippy tile generation
get '/tiles/:tile/:x/:y/:z.png' do

  # Let the browser know we are sending a png
  content_type 'image/png'

  tiles = YAML.load_file('tiles.yml')
  tile = tiles[params[:tile].to_i]

  # Create a Map object
  map = SimplerTiles::Map.new do |m|
    # Set the background color to black
    m.bgcolor = tile["bgcolor"]

    # Set the slippy map parameters from the url
    m.slippy params[:x].to_i, params[:y].to_i, params[:z].to_i

    # Important: set srs after slippy or it will get overridden
    m.srs     = tile["srs"]
    # Add a layer based on the parameters in the URL
    m.layer File.join("#{Dir.pwd}/tile/shapes/#{tile["filename"]}") do |l|

      # Grab all of the data from the shapefile
      l.query "select * from '#{tile["layername"]}'" do |q|

        # Add a style for stroke, fill, weight and set the line-join to be round
        q.styles 'stroke' => tile["styles"]["stroke"],
                 'weight' => tile["styles"]["weight"],
              'line-join' => tile["styles"]["line-join"],
                   'fill' => tile["styles"]["fill"]
      end

      l.query "select * from '#{tile["layername"]}'" do |q|
        q.styles 'text-field' => 'NAME',
                'color' => '#444444ff',
                 'text-outline-color' => '#ffffffcc',
                 'text-outline-weight' => '2',
                 'font' => 'Helvetica 12px'
      end
    end
  end
  p map.inspect

  # Finally, render the map and ship it off
  map.to_png
end
