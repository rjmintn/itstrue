# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.all

collaborators = Collaborator.all

# 6.times do |count|
#   user = User.create!(
#   email:
#   )

15.times do |count|
  wiki = Wiki.create!(
    title: "#{count.to_s} " + Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph(2,false,4),
    private: Faker::Boolean.boolean,
    user_id: users.sample.id
  )
  wiki.update_attributes(:created_at => Faker::Date.between(12.months.ago, 6.months.ago),  :updated_at => Faker::Date.between(5.months.ago, Date.today))

  wiki = Wiki.create!(
    title: "#{count.to_s} " + Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph(2,false,4),
    private: true,
    user_id: 1
  )
  wiki.update_attributes(:created_at => Faker::Date.between(12.months.ago, 6.months.ago),  :updated_at => Faker::Date.between(5.months.ago, Date.today))
end

# loop through private wikis and assign collaborators
wikis = Wiki.all

wikis.each do |wiki|
  rand(1..5).times do
    u_id = rand(1..users.count)
    unless u_id != wiki.user_id
      u_id = rand(1..users.count)
    end

    if wiki.private
      collab = Collaborator.create!(
        user_id: u_id,
        wiki_id: wiki.id
      )
    end
  end
end
