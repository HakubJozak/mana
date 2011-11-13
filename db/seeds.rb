# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Daley', city: cities.first)
# Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)
# puts 'SETTING UP DEFAULT USER LOGIN'
# user = User.create! :name => 'First User', :email => 'user@test.com', :password => 'please', :password_confirmation => 'please'
# puts 'New user created: ' << user.name

db = Mongoid.database

counters = db.create_collection('counters')
counters.insert(_id: "card_stamps", counter: 0)

code = <<-eos
           function next_counter() {
             return db.counters.findAndModify({query: {_id: "card_stamps"}, update: {$inc: {counter: 1}}}).counter;
           }
          eos

db.add_stored_function 'next_counter', code
