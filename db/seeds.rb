# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.all

25.times do |count|
  wiki = Wiki.create!(
    title: "#{count.to_s} " + Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph(2,false,4),
    private: Faker::Boolean.boolean,
    user_id: users.sample
  )
  wiki.update_attributes(:created_at => Faker::Date.between(12.months.ago, 6.months.ago),  :updated_at => Faker::Date.between(5.months.ago, Date.today))
end
