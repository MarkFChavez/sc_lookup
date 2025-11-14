require "json"

clients_file = File.read(ARGV[0])

# Ask for user input
puts "What command do you want to execute?"
puts "------------------------------------"
puts "client_search"
puts "email_dup_search"
print "Command: "
cmd_input = STDIN.gets.chomp

case cmd_input.to_s.downcase
when "client_search"

  # Do client search
  puts "You chose #{cmd_input}"
  puts "-----------------------"
  print "Search client name: "
  client_name_input = STDIN.gets.chomp

  clients_array = JSON.parse(clients_file)
  clients = clients_array.select do |client_hash|
    client_hash["full_name"].downcase.include?(client_name_input.downcase)
  end

  if clients.empty?
    puts "No clients matched your search '#{client_name_input}'"
    return
  end

  # Output:
  puts "Clients found:"
  puts clients

when "email_dup_search"

  puts "Returning clients with duplicate emails"
  clients_array = JSON.parse(clients_file)

  clients_with_duplicate_emails = clients_array.group_by do |client_hash|
    client_hash["email"]
  end.select do |_email, how_many|
    how_many.size > 1
  end.values.flatten

  if clients_with_duplicate_emails.empty?
    puts "No clients with matching emails"
    return
  end

  # Output:
  puts "Clients with matching emails:"
  puts clients_with_duplicate_emails

else

  puts "Invalid command '#{cmd_input}'. Try again."

end
