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


Job.create([
  { name: 'Plumber' },
  { name: 'Welder' },
  { name: 'Programmer' },
  { name: 'Designer' },
  { name: 'Executive' },
])



Location.create([
  {
      slug: 'cohesive',
      address_attributes: {
        street: '100 Eddystone Drive',
        city: 'Hudson',
        state: 'IA',
        zip: '50613'
      }
  }
])
