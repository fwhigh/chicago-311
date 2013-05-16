require 'json'

json_data = File.open('data/fake_geo_json.txt', 'r').read

data = JSON.parse(json_data)

geojson = []

data.each_pair do |k, v|
	geojson << { 
		type: 'Feature', 
		properties: { 
			time: v['time'] 
		}, 
		geometry: { 
			type: 'Point', 
			coordinates: [v['coord']['lon'], v['coord']['lat']] 
		} 
	}
end

geojson = { type: 'FeatureCollection', features: geojson }

File.open('data/fake_geo_json.geojson', 'w') do |file|
	file.write(geojson.to_json)
end