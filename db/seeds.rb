# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

phil = User.create!(email: "phil@purpleriver.dev", first_name: "Phil", last_name: "Reynolds", password: "test1234", password_confirmation: "test1234", town: "swansea", confirmed_at: Time.now)
calum = User.create!(email: "calum@mcclume.me", first_name: "Calum", last_name: "McClune", password: "test1234", password_confirmation: "test1234", town: "swansea", confirmed_at: Time.now)
tom = User.create!(email: "tomfostephens@gmail.com", first_name: "Tom", last_name: "Stephens", password: "test1234", password_confirmation: "test1234", town: "swansea", confirmed_at: Time.now)
ciaran = User.create!(email: "ciaraen_browning@hotmail.co.uk", first_name: "Ciaran", last_name: "Browning", password: "test1234", password_confirmation: "test1234", town: "swansea", confirmed_at: Time.now)
jon = User.create!(email: "Jon.r.twig@gmail.com", first_name: "Jon", last_name: "Twigg", password: "test1234", password_confirmation: "test1234", town: "swansea", confirmed_at: Time.now)
suz = User.create!(email: "s-ka-t@hotmail.co.uk", first_name: "Suzanne", last_name: "Thomas", password: "test1234", password_confirmation: "test1234", town: "swansea", confirmed_at: Time.now)
bryony = User.create!(email: "bryonybluefearn@gmail.com", first_name: "Bryony", last_name: "Bluefearn", password: "test1234", password_confirmation: "test1234", town: "swansea", confirmed_at: Time.now)
unconnected_test = User.create!(email: "unconnected@purplriver.dev", first_name: "Unconnected", last_name: "Test", password: "test1234", password_confirmation: "test1234", town: "swansea", confirmed_at: Time.now)

phil.create_connection_with(calum)
phil.create_connection_with(tom)
phil.create_connection_with(ciaran)
phil.create_connection_with(jon)
phil.create_connection_with(suz)
phil.create_connection_with(bryony)
calum.create_connection_with(tom)
calum.create_connection_with(ciaran)
calum.create_connection_with(jon)
calum.create_connection_with(suz)
calum.create_connection_with(bryony)
tom.create_connection_with(ciaran)
tom.create_connection_with(jon)
tom.create_connection_with(suz)
tom.create_connection_with(bryony)
ciaran.create_connection_with(jon)
ciaran.create_connection_with(suz)
ciaran.create_connection_with(bryony)
jon.create_connection_with(suz)
jon.create_connection_with(bryony)
suz.create_connection_with(bryony)

trade_names = [
  "Plumber", "Electrician", "Carpenter", "Joiner", "Plasterer", "Decorator", "Builder", "Gardener", "Fence", "Roofer",
  "Tiler", "Floorer", "Kitchen Fitter", "Bathroom Fitter", "Window Fitter", "Scaffolder", "Rubbish Clearance"
]
Trade.create(trade_names.map { |name| { name: name } })

c_shaun = phil.added_contractors.create!(name: "Shaun Reed", company_name: "Reeds Renovations", number: "07123000123", town: "Swansea", email: "reedsrenovations@hotmail.com")
c_paul = phil.added_contractors.create!(name: "Paul Swinford", company_name: "Swinford Sparks", number: "07123000124", town: "Swansea", email: "swinfordsparks@gmail.com")
c_abbas = calum.added_contractors.create!(name: "Abbas", company_name: "RAM Plastering", number: "07458171780", town: "Swansea")
c_james = phil.added_contractors.create!(name: "James", company_name: "Supreme Plastering", number: "07760102335", town: "Swansea")

[ "Plumber", "Plasterer", "Bathroom Fitter", "Kitchen Fitter", "Builder", "Tiler" ].each do |trade_name|
  c_shaun.trades << Trade.find_by(name: trade_name)
end
c_paul.trades << Trade.find_by(name: "Electrician")
c_abbas.trades << Trade.find_by(name: "Plasterer")
c_james.trades << Trade.find_by(name: "Plasterer")

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

phil.ratings.create!(contractor: c_shaun, overall_rating: 9, review: "Shaun was fantastic, would highly recommend")
phil.ratings.create!(contractor: c_paul, overall_rating: 9, review: "Paul was great, would use again")
calum.ratings.create!(contractor: c_abbas, overall_rating: 8, review: "Abbas was good, About £240 a day (2023), would use again.")
bryony.ratings.create!(contractor: c_abbas, overall_rating: 8, review: "Abbas was good, would recommend")
phil.ratings.create!(contractor: c_james, overall_rating: 8, review: "James was good, would recommend")
bryony.ratings.create!(contractor: c_james, overall_rating: 3, review: "Had some difficulty with the awkward bits, wouldn't use again")
