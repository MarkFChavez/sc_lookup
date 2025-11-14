require "json"
require_relative "./lib/finder"

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

  clients = Finder.search!(clients_file, client_name_input)

  if clients.empty?
    puts "No clients matched your search '#{client_name_input}'"
    return
  end

  # Output:
  puts "Clients found:"
  puts clients

when "email_dup_search"

  puts "Returning clients with duplicate emails"

  clients = Finder.with_duplicates!(clients_file)

  if clients.empty?
    puts "No clients with matching emails"
    return
  end

  # Output:
  puts "Clients with matching emails:"
  puts clients

else

  puts "Invalid command '#{cmd_input}'. Try again."

end
