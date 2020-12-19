# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'faker'

Message.destroy_all
Request.destroy_all
Pet.destroy_all
User.destroy_all

randnum = (1..11).to_a.shuffle

10.times do
  user = User.new(
    email: "testeuser#{randnum.pop}@hotmail.com",
    password: "123456",
    first_name: Faker::Name.first_name,
    last_name:  Faker::Name.last_name,
    birth_date: Faker::Date.between(from: 40.years.ago, to: 18.years.ago),
    about_me: ["I´m a very nice person that loves animals and their company. I already have two dogs, one cat and four birds",
                "I live in a big farm with my kids. We have lots of space and we are looking for more pet comapny",
                "I live by myself downtown on a cozy appartament. I´m looking for a pet to make me company at night when i´m home.",
                "Hello, i´m a very athletic person and i am looking for a buddy to be with me on my many adventures",
                "Hey, we are a big family who loves all animals. We have a big farm where the dogs run free and the birds fly high",
                "I´m really dedicated to my work, so i´m looking for a pet that needs less attention and care, but will always be there for me",
                "Whats up my friends? I am the MOST dog person ever, i have a big house and would love to fill it with the men´s best friend"].sample
  )
  gender = ["woman", "man"]
  file = open("https://loremflickr.com/320/240/#{gender.sample}")
  user.photo.attach(io: file, filename: 'petav.jpg')
  user.save!
end

description = ["A very nice and beautiful dog! Found it in a very sad situation, but it is ok now!",
              "It is very active, likes playing, and very friendly! Please take care of him!",
              "At first, it is very shy, but after you become trustful, it'll become your best friend!",
              "A very active pet, it is always looking for company. I´m sure it will be great friends with you",
              "I am a very sleepy pet, with night habbits, if you like staying up late i am the perfect company",
                "This is the most playfull pet i´ve ever seen. Fun times are guaranteed with it.",
              "People say, the best friend of the humankind is the dog. But this one is the best friend of the best friends you have! The bestest!"]

randuser = User.all.ids.shuffle

5.times do
  puts 'printing a description'
  puts '.....'
  puts description.sample
  pet = Pet.new(
      name: Faker::Creature::Dog.name,
      found_date: Faker::Date.between(from: 40.days.ago, to: Date.today),
      description: description.sample,
      species: "Dog",
      breed: Faker::Creature::Dog.breed,
      size: Pet::SIZES.sample,
      age: Pet::AGES.sample,
      state: 'Rio de Janeiro',
      city: ['Volta Redonda', 'Rio de Janeiro', 'Niterói', 'Cabo Frio', 'Angra dos Reis', 'Paraty', 'Itatiaia', 'Resende'].sample,
      neighborhood: ['São João', 'Jardim Belo', 'São Sebastião', 'Centro','South side', 'Downtown', 'Bus Station'].sample,
      adopted: false,
      user_id: randuser.pop
      )
  puts 'printing pet description'
  puts '.....'
  puts pet.description
  file = open('https://loremflickr.com/320/240/dog')
  pet.photo.attach(io: file, filename: 'petav.jpg')
  pet.save!
end

5.times do
    puts 'printing a description'
  puts '.....'
  puts description.sample
  pet = Pet.new(
      name: Faker::Creature::Cat.name,
      found_date: Faker::Date.between(from: 40.days.ago, to: Date.today),
      description: description.sample,
      species: "Cat",
      breed: Faker::Creature::Cat.breed,
      size: Pet::SIZES.sample,
      age: Pet::AGES.sample,
      state: 'Rio de Janeiro',
      city: ['Volta Redonda', 'Rio de Janeiro', 'Niterói', 'Cabo Frio', 'Angra dos Reis', 'Paraty', 'Itatiaia', 'Resende'].sample,
      neighborhood: ['São João', 'Jardim Belo', 'São Sebastião', 'Centro'].sample,
      adopted: false,
      user_id: randuser.pop
      )
    puts 'printing pet description'
  puts '.....'
  puts pet.description
  file = open('https://loremflickr.com/320/240/cat')
  pet.photo.attach(io: file, filename: 'petav.jpg')
  pet.save!
end
