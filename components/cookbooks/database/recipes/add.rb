# create the DB and user
require 'json'

payload = node.workorder.payLoad
depends_on = Array.new

if payload.has_key?('DependsOn')
  depends_on = payload.DependsOn.select { |db| 
    db['ciClassName'].split('.').last == "Postgresql" || 
    db['ciClassName'].split('.').last == "Mysql" || 
	db['ciClassName'].split('.').last == "Mssql" || 
    db['ciClassName'].split('.').last == "Oracle"  
  }
end

db_type = ""
case 
when depends_on.size == 0
  pack_name = node.workorder.box.ciAttributes["pack"]
  if pack_name =~ /postgres|oracle|mssql|mysql/
    db_type = pack_name
    Chef::Log.info("Using db_type: "+db_type+ " via box")
  else
    exit_with_error "Unable to find a DB server information in the request. Exiting."
  end
when depends_on.size == 1
  dbserver = depends_on.first
  node.default[:database][:dbserver] = dbserver
  Chef::Log.info("Using dbserver #{dbserver['ciName']}")
  db_type = dbserver['ciClassName'].split('.').last.downcase
when depends_on.size > 1
  exit_with_error "Multiple DB servers found. Exiting due to ambigous data."
end

include_recipe "database::#{db_type}"
pretty_json = JSON.pretty_generate(node)
::File.open('/opt/oneops/database_node', 'w') {|f| f.write( pretty_json ) }
