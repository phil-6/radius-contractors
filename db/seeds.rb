# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

phil = User.create!(email: "phil@purpleriver.dev", first_name: "Phil", last_name: "Reynolds", password: "test1234", password_confirmation: "test1234", town: "Swansea", confirmed_at: Time.now)
calum = User.create!(email: "calum@mcclune.me", first_name: "Calum", last_name: "McClune", password: "test1234", password_confirmation: "test1234", town: "Swansea", confirmed_at: Time.now)
tom = User.create!(email: "tomofstephens@gmail.com", first_name: "Tom", last_name: "Stephens", password: "test1234", password_confirmation: "test1234", town: "Swansea", confirmed_at: Time.now)
ciaran = User.create!(email: "ciaran_browning@hotmail.co.uk", first_name: "Ciaran", last_name: "Browning", password: "test1234", password_confirmation: "test1234", town: "Swansea", confirmed_at: Time.now)
jon = User.create!(email: "Jon.r.twigg@gmail.com", first_name: "Jon", last_name: "Twigg", password: "test1234", password_confirmation: "test1234", town: "Swansea", confirmed_at: Time.now)
suz = User.create!(email: "s-k-t@hotmail.co.uk", first_name: "Suzanne", last_name: "Thomas", password: "test1234", password_confirmation: "test1234", town: "Swansea", confirmed_at: Time.now)
bryony = User.create!(email: "bryonyredfearn@gmail.com", first_name: "Bryony", last_name: "Redfearn", password: "test1234", password_confirmation: "test1234", town: "Swansea", confirmed_at: Time.now)
holly = User.create!(email: "HollyRedfearn@gmail.com", first_name: "Holly", last_name: "Redfearn", password: "test1234", password_confirmation: "test1234", town: "Swansea", confirmed_at: Time.now)
unconnected_test = User.create!(email: "unconnected@purplriver.dev", first_name: "Unconnected", last_name: "Test", password: "test1234", password_confirmation: "test1234", town: "Swansea", confirmed_at: Time.now)

calum.create_connection_with(phil)
tom.create_connection_with(phil)
ciaran.create_connection_with(phil)
jon.create_connection_with(phil)
suz.create_connection_with(phil)
bryony.create_connection_with(phil)
holly.create_connection_with(phil)
tom.create_connection_with(calum)
ciaran.create_connection_with(calum)
jon.create_connection_with(calum)
suz.create_connection_with(calum)
bryony.create_connection_with(calum)
holly.create_connection_with(calum)
ciaran.create_connection_with(tom)
jon.create_connection_with(tom)
suz.create_connection_with(tom)
bryony.create_connection_with(tom)
holly.create_connection_with(tom)
jon.create_connection_with(ciaran)
suz.create_connection_with(ciaran)
bryony.create_connection_with(ciaran)
holly.create_connection_with(ciaran)
suz.create_connection_with(jon)
bryony.create_connection_with(jon)
holly.create_connection_with(jon)
bryony.create_connection_with(suz)
holly.create_connection_with(ciaran)

trade_names = [
  "Plumber", "Gas Safe Plumber (Boilers)", "Electrician", "Carpenter", "Joiner", "Plasterer", "Decorator", "Painter", "Builder", "Gardener",
  "Fence", "Roofer", "Tiler", "Floorer", "Kitchen Fitter", "Bathroom Fitter", "Window Fitter", "Scaffolding", "Rubbish Clearance", "Skip",
  "Bricklayer", "General", "Other", "Carpet Fitter", "Chimney Sweep", "Fireplace Fitting"
]
Trade.create(trade_names.map { |name| { name: name } })

c_shaun = phil.added_contractors.create!(name: "Shaun Reed", company_name: "Reeds Renovations", number: "07977297099", town: "Swansea", email: "reedsrenovations@hotmail.com")
c_paul = phil.added_contractors.create!(name: "Paul Swinford", company_name: "Swinford Sparks", number: "07769338433", town: "Swansea", email: "swinfordsparks@gmail.com")
c_abbas = calum.added_contractors.create!(name: "Abbas", company_name: "RAM Plastering", number: "07458171780", town: "Swansea")
c_james = phil.added_contractors.create!(name: "James", company_name: "Supreme Plastering", number: "07760102335", town: "Swansea")
c_chris = phil.added_contractors.create!(name: "Chris Walters", company_name: "Chris Walters Plumbing & Heating", number: "07846214934", town: "Swansea", email: "Chriswaltersplumbing@gmail.com")
c_lee = holly.added_contractors.create!(name: "Lee Williams", number: "07891814000", email: "leewilliams11@hotmail.com", town: "Swansea")

[ "Plumber", "Plasterer", "Bathroom Fitter", "Kitchen Fitter", "Builder", "Tiler" ].each do |trade_name|
  c_shaun.trades << Trade.find_by(name: trade_name)
end
c_paul.trades << Trade.find_by(name: "Electrician")
c_abbas.trades << Trade.find_by(name: "Plasterer")
c_james.trades << Trade.find_by(name: "Plasterer")
c_chris.trades << Trade.find_by(name: "Plumber")
c_lee.trades << Trade.find_by(name: "Plumber")

phil.jobs.create!(contractor: c_shaun, description: "Bathroom renovation", town: "Swansea",
                  start_date: Date.new(2024, 5, 1), end_date: Date.new(2024, 10, 1),
                  cost: 5000, state: "completed")
phil.jobs.create!(contractor: c_paul, description: "Rewire rear half of house", town: "Swansea",
                  start_date: Date.new(2024, 5, 1), end_date: Date.new(2024, 10, 1),
                  cost: 3000, state: "completed")
phil.jobs.create!(contractor: c_shaun, description: "Kitchen renovation", town: "Swansea",
                  start_date: Date.new(2024, 5, 1), end_date: Date.new(2024, 10, 1),
                  cost: 20000, state: "completed")
phil.jobs.create!(contractor: c_shaun, description: "New Roof", town: "Swansea",
                  start_date: Date.new(2024, 5, 1), end_date: Date.new(2024, 10, 1),
                  cost: 10000, state: "completed")
calum.jobs.create!(contractor: c_abbas, description: "Plastering", town: "Swansea",
                   start_date: Date.new(2023, 5, 1), end_date: Date.new(2024, 5, 10),
                   cost: 500, state: "completed")
bryony.jobs.create!(contractor: c_abbas, description: "Plastering", town: "Swansea",
                    start_date: Date.new(2023, 5, 10), end_date: Date.new(2023, 5, 20),
                    cost: 500, state: "completed")
phil.jobs.create!(contractor: c_james, description: "Plastering", town: "Swansea",
                  start_date: Date.new(2023, 2, 1), end_date: Date.new(2023, 2, 10),
                  cost: 500, state: "completed")
bryony.jobs.create!(contractor: c_james, description: "Plastering", town: "Swansea",
                    start_date: Date.new(2023, 2, 10), end_date: Date.new(2023, 2, 20),
                    cost: 500, state: "completed")
phil.jobs.create!(contractor: c_chris, description: "Plumbing", town: "Swansea",
                  start_date: Date.new(2023, 2, 1),
                  cost: 500, state: "completed")
holly.jobs.create!(contractor: c_lee, description: "Carried out first fit of a new bathroom - running pipes and waste for concealed shower, sink and toilet, then removing old radiator, moving pipework and attaching new radiator",
                   town: "Swansea", start_date: Date.new(2024, 2, 1), end_date: Date.new(2024, 2, 10),
                   cost: 850, state: "completed")

phil.ratings.create!(contractor: c_shaun, overall_rating: 9, review: "Shaun was fantastic, would highly recommend")
phil.ratings.create!(contractor: c_paul, overall_rating: 9, review: "Paul was great, would use again")
calum.ratings.create!(contractor: c_abbas, overall_rating: 8, review: "Abbas was good, About £240 a day (2023), would use again.")
bryony.ratings.create!(contractor: c_abbas, overall_rating: 8, review: "Abbas was good, would recommend")
phil.ratings.create!(contractor: c_james, overall_rating: 8, review: "James was good, would recommend")
bryony.ratings.create!(contractor: c_james, overall_rating: 3, review: "Had some difficulty with the awkward bits, wouldn't use again")
phil.ratings.create!(contractor: c_chris, overall_rating: 9, review: "Chris' price was great and work was exceptional. Be prepared to book well in advance as he is in demand!")
holly.ratings.create!(contractor: c_lee, overall_rating: 9, review: "Really nice to work with and did a very neat job, will be using for all our other plumbing")

c_geoff = phil.added_contractors.create!(name: "Geoff Flynn", company_name: "Efficient Gas Services", number: "07528 558638", email: "geoff@efficientgasswansea.co.uk", town: "Swansea")
c_geoff.trades << Trade.find_by(name: "Gas Safe Plumber (Boilers)")
phil.jobs.create!(contractor: c_geoff, description: "Boiler replacement", town: "Swansea", start_date: Date.new(2018, 1, 1), end_date: Date.new(2018, 1, 10), cost: 2000, state: "completed")
phil.jobs.create!(contractor: c_geoff, description: "Boiler servicing", town: "Swansea", start_date: Date.new(2021, 2, 1), end_date: Date.new(2019, 2, 2), cost: 150, state: "completed")
phil.jobs.create!(contractor: c_geoff, description: "Radiator installations", town: "Swansea", start_date: Date.new(2022, 3, 1), end_date: Date.new(2020, 3, 5), cost: 500, state: "completed")
phil.ratings.create!(contractor: c_geoff, overall_rating: 7, review: "Geoff was good, highly recommend for boiler services and radiator installations. A little disinterested lately. Often works with 'Powerflush heating'")

c_jake = phil.added_contractors.create!(name: "Jake Lovell", company_name: "Lovell’s Roofing and Building", number: "07458 178705", email: "lovellsroofing@icloud.com", town: "Swansea")
c_jake.trades << Trade.find_by(name: "Roofer")
phil.jobs.create!(contractor: c_jake, description: "Main roof repair", town: "Swansea", start_date: Date.new(2021, 1, 1), end_date: Date.new(2021, 1, 10), cost: 7800, state: "completed")
phil.ratings.create!(contractor: c_jake, overall_rating: 6, review: "Jake and his team were really nice, helpful, and professional. Communication could be better, but pleased with the work. They eventually fixed a defect under guarantee.")

c_tom = phil.added_contractors.create!(name: "Tom Price", company_name: "Coastal Roofing", number: "07810 193009", town: "Swansea")
c_tom.trades << Trade.find_by(name: "Roofer")
phil.jobs.create!(contractor: c_tom, description: "Chimney cap replacement", town: "Swansea", start_date: Date.new(2022, 4, 1), end_date: Date.new(2022, 4, 2), cost: 300, state: "completed")
phil.jobs.create!(contractor: c_tom, description: "Garage roof", town: "Swansea", start_date: Date.new(2023, 5, 1), end_date: Date.new(2023, 5, 5), cost: 1200, state: "completed")
phil.ratings.create!(contractor: c_tom, overall_rating: 7, review: "Tom was reliable and affordable. Overall solid 7/10. Missing some attention to detail and quality.")

c_karl = phil.added_contractors.create!(name: "Karl", company_name: "Coastal Scaffolding", number: "07976 657166", town: "Swansea")
c_karl.trades << Trade.find_by(name: "Scaffolding")
phil.jobs.create!(contractor: c_karl, description: "Main roof repair scaffolding", town: "Swansea", start_date: Date.new(2021, 1, 1), end_date: Date.new(2021, 1, 10), cost: 1000, state: "completed")
phil.ratings.create!(contractor: c_karl, overall_rating: 6, review: "Karl was okay, but his methods did crack roof tiles.")

c_viv = phil.added_contractors.create!(name: "?", company_name: "Bont Scaffolding / Viv John Scaffolding", number: "07860532830", town: "Swansea")
c_viv.trades << Trade.find_by(name: "Scaffolding")
phil.jobs.create!(contractor: c_viv, description: "Front and back scaffolding", town: "Swansea", start_date: Date.new(2020, 11, 30), end_date: Date.new(2020, 12, 10), cost: 1100, state: "quote")
phil.jobs.create!(contractor: c_viv, description: "Chimney repair scaffolding", town: "Swansea", start_date: Date.new(2016, 6, 1), end_date: Date.new(2016, 6, 10), cost: 800, state: "completed")
phil.ratings.create!(contractor: c_viv, overall_rating: 7, review: "Quoted £1100 for front and back scaffolding. Used in 2016 for chimney repair.")

c_gareth = phil.added_contractors.create!(name: "Gareth Williams", company_name: "Mumbles Electric", number: "07528558638", email: "gareth@mumbleselectric.co.uk", town: "Swansea")
c_gareth.trades << Trade.find_by(name: "Electrician")
phil.jobs.create!(contractor: c_gareth, description: "Fixed fault with lights and cooker tripping", town: "Swansea", start_date: Date.new(2023, 6, 1), end_date: Date.new(2023, 6, 2), cost: 200, state: "completed")
phil.ratings.create!(contractor: c_gareth, overall_rating: 8, review: "Gareth was really good, fixed a fault with lights and cooker tripping.")

c_andrew = phil.added_contractors.create!(name: "Andrew", company_name: "Fire Ex", town: "Swansea", number: "07837875197")
c_andrew.trades << Trade.find_by(name: "Electrician")
phil.jobs.create!(contractor: c_andrew, description: "Original house rewire", town: "Swansea", start_date: Date.new(2015, 10, 1), end_date: Date.new(2015, 10, 31), cost: 3065, state: "completed")
phil.ratings.create!(contractor: c_andrew, overall_rating: 3, review: "Andrew did the original house rewire. Quality was low, but so was price. Although it is still working, the house is going to need another rewire at some point.")

c_david = phil.added_contractors.create!(name: "David", company_name: "Bartletts Joinery", number: "07897555202", town: "Swansea")
c_david.trades << Trade.find_by(name: "Joiner")
phil.jobs.create!(contractor: c_david, description: "Replacing decorative fascia", town: "Swansea", start_date: Date.new(2023, 7, 1), end_date: Date.new(2023, 7, 2), cost: 1100, state: "completed")
phil.ratings.create!(contractor: c_david, overall_rating: 8, review: "David did a good job replacing the decorative fascia. Expensive but great work")

c_full_focus = phil.added_contractors.create!(name: "?", company_name: "Full Focus", number: "07572702374", town: "Swansea")
c_full_focus.trades << Trade.find_by(name: "Joiner")
phil.jobs.create!(contractor: c_full_focus, description: "Replacing decorative fascia", town: "Swansea", start_date: Date.new(2023, 7, 1), end_date: Date.new(2023, 7, 2), cost: 2200, state: "quote")
phil.ratings.create!(contractor: c_full_focus, overall_rating: 8, review: "Quoted for replacing decorative fascia. Was double the cost of Bartletts but seemed really good.")

c_ian = bryony.added_contractors.create!(name: "Ian Budge", number: "07734906643", town: "Swansea")
c_ian.trades << Trade.find_by(name: "Carpenter")
bryony.jobs.create!(contractor: c_ian, description: "Skirts, picture rails and adjusting doors", town: "Swansea", start_date: Date.new(2023, 1, 1), end_date: Date.new(2023, 1, 2), cost: 180, state: "completed")
bryony.ratings.create!(contractor: c_ian, overall_rating: 8, review: "Ian did a good job with skirts, picture rails and adjusting doors. Charges about £180 a day plus materials depending on the type of work.")
