desc "Create Roles for Access"
task :create_roles => :environment do
  roles = [ ["master", "Master of the whole website."], 
            ["admin", "Admin of the organizations"],
            ["accountant", "Accountant of organization"], 
            ["payer", "Payer of organization"], 
            ["approver", "Approver of organization"], 
            ["clerk", "Clerk of organization"] ]
  roles.each do |role|
    Role.create(name: role[0], description: role[1])
    puts "Role '#{role[0]} - #{role[1]}' is created."
  end
end