# CMS user
u = CohesiveAdmin::User.new({ name: "Admin User", email: "info@cohesive.cc", password: 'password', password_confirmation: 'password', user_type: "Administrator" })
u.save(validate: false)

# Sample people
@first = ["Tom", "John", "Jane", "Sally"]
@last = ["Johnson", "Smith", "Brown", "Miller"]

@people = []
10.times do |i|
  names = [@first.sample, @last.sample]

  @people << { name: names.join(" "), email: "#{names.join(".").downcase}@example.com" }
end

Person.create(@people.uniq)


["Plumber", "Welder", "Programmer", "Designer", "Executive"].each do |j|
  Job.create({ name: j })
end
