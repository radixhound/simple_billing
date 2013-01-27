# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(username: 'admin', email: 'admin@admin.com', password: '123456', 
            password_confirmation: '123456', admin: true)

User.create(username: 'gabe', email: 'gabe@gabe.com', password: '123456', 
            password_confirmation: '123456', admin: false)

bill = User.create(username: 'bill', email: 'bill@example.com',
            admin: false)
bill.create_signup_token
bill.save!

bill.invoices.create!(title: 'hi', amount: 4, payable: true)