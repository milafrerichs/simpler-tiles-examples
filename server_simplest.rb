require 'rubygems'
require 'sinatra'
require 'simpler_tiles'

get '/tiles/:tile/:x/:y/:z.png' do
  content_type 'image/png'
  map = SimplerTiles::Map.new do |m|
    m.bgcolor = "#000000"
    m.slippy params[:x].to_i, params[:y].to_i, params[:z].to_i
    m.layer File.join("#{Dir.pwd}/tile/shapes/ne_110m_admin_0_countries_lakes.shp") do |l|
      l.query "select * from 'ne_110m_admin_0_countries_lakes'"
    end
  end
  map.to_png
end
