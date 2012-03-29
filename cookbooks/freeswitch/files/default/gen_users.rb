#!/usr/local/bin/ruby
# generate XML configuration for 10 FreeSwitch users.
# Optionally specify number of users as an argument.
# Depends on the pwgen system utility.

# TODO: write restore function to use values from concise_list to rebuild XML
# from a backup.
#
require 'rubygems'
require 'xmlsimple'

first = 1000
last = first + 10
if (ARGV[0])
  last = first + ARGV[0].to_i
end
pwgen = `which pwgen`.chop!
if (pwgen.nil?) 
  puts "This program depends on the pwgen utility. Please install it."
  exit 1
end
user_list = ""

# generate a bunch of XML files
# WARNING! THIS SCRIPT IS NOT NICE. IT WILL OVERWRITE FILES!
#
(first...last).each do |i|
  pw = `#{pwgen} -nc`.chop!
  config = {
    "user"=> {
      i.to_s => {
      "mailbox" => i.to_s,
      "variables" => [{
        "variable" => [{
        "name" => "accountcode",
        "value"=> i.to_s
      },
      {
        "name" => "user_context",
        "value" => "default"
      },
      {
        "name" => "effective_caller_id_name",
        "value" => "Extension #{i.to_s}"
      },
      {
        "name" => "effective_caller_id_number",
        "value" => i.to_s
      }]}],
      "params" => [{
        "param" => [{
          "name" => "password",
          "value" => pw
        },
        {
          "name" => "vm-password",
          "value" => pw
        }]}]
      }
    }
  }
  xml_config = XmlSimple.xml_out(config, { 'KeyAttr' => 'id', 'RootName' => "include" })
  fh = File.new( "#{i.to_s}.xml", "w")
  fh.write(xml_config)
  fh.close
  concise_string = i.to_s + ":" + pw
  user_list << concise_string + "\n"
  puts concise_string
end
puts "Finished creating XML #{ last - first } users"
#
# Write full list of usernames and passwords in a more concise format, perhaps
# for an admin to encrypt and carry around
fh = File.new( "user_list.txt", "w")
fh.write(user_list)
puts "Wrote #{ last - first } usernames and passwords to #{fh.path}"
fh.close