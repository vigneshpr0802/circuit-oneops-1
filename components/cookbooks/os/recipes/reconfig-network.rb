
# Set some metadata that's not available while in this
# procedure mode 

node.set["workorder"]["rfcCi"]["ciAttributes"]["hosts"] = "{}"
node.set["workorder"]["rfcCi"]["ciName"]  = node.workorder.ci.ciName
node.set["workorder"]["rfcCi"]["ciId"] = node.workorder.ci.ciId
node.set["workorder"]["rfcCi"]["ciAttributes"]["additional_search_domains"] = node.workorder.ci.ciAttributes.additional_search_domains
node.set["workorder"]["rfcCi"]["ciAttributes"]["dhclient"] = node.workorder.ci.ciAttributes.dhclient
node.set["vmhostname"] = node.workorder.box.ciName+'-'+node.workorder.cloud.ciId.to_s+'-'+node.workorder.ci.ciName.split('-').last.to_i.to_s+'-'+ node.workorder.ci.ciId.to_s
node.set["full_hostname"] = node["vmhostname"]+'.'+node["customer_domain"]

# Rename existing dhclient.conf for backup
execute "mv -f /etc/dhcp/dhclient.conf /etc/dhcp/dhclient.conf.#{Time.now.to_i}" do
  only_if { ::File.exist?('/etc/dhcp/dhclient.conf') }
end

dhclient_cmdline = "/sbin/dhclient"

# try to use options that its running with
dhclient_ps = `ps auxwww|grep -v grep|grep dhclient`
if dhclient_ps.to_s =~ /.*:\d{2} (.*dhclient.*)/
  dhclient_cmdline = $1
end

dhclient_cmdline = dhclient_cmdline + " &"

# kill dhclient so we can regenerate /etc/resolv.conf
`pkill -f dhclient`

# Start dhclient again to get default values from dhcp server
output = `#{dhclient_cmdline}`

if node["workorder"]["rfcCi"]["ciAttributes"]["dhclient"] != 'true'
  `pkill -f dhclient`
end

# run the network script
include_recipe "os::network"
