namespace :tariffs do
  desc "mass creation of intercity tariffs"
  task :intercity, [:yaml_file] =>:environment do |t, args|
    file = args.yaml_file
    file += '.yml' if File.extname(file) != '.yml'
    yaml_file = Rails.root.join("db", "samples", "delivery_city_relations", file)
    cities = YAML::load_file(yaml_file)['cities']
    destinations = YAML::load_file(yaml_file)['destination']
    destinations.each do |destination|
      i = 0
      cities.each do |city|
        city_from = City.find_by_name(city['name'])
        city_to = City.find_by_name(destination['city'])
        delivery_city_relation = city_from.delivery_city_relations.where(city_to_id: city_to.id).first
        if !delivery_city_relation
          delivery_city_relation = DeliveryCityRelation.new
          delivery_city_relation.city_from = city_from
          delivery_city_relation.city_to = city_to
        end
        delivery_city_relation.zones << Zone.find_by_name_and_provider(destination['zone_attributes'][i]['zone'],'major_express')
        #TODO: FIX THIS
        delivery_city_relation.delivery_time = destination['zone_attributes'][i]['time']
        delivery_city_relation.save!
        i += 1
      end
    end
  end
end