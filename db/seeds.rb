# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

15.times do
  Report.create(name: "Ella", phone: "209-559-2459", lat: 37.782983333333334, long: 122.4065, nature: "they tuk our jobs")

end
