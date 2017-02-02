
# Set some metadata that's not available while in this
# procedure mode 

node.set["workorder"]["rfcCi"]["ciAttributes"]["hosts"] = "{}"
node.set["workorder"]["rfcCi"]["ciName"]  = node.workorder.ci.ciName
node.set["workorder"]["rfcCi"]["ciId"] = node.workorder.ci.ciId
node.set["workorder"]["rfcCi"]["ciAttributes"]["additional_search_domains"] = node.workorder.ci.ciAttributes.additional_search_domains
node.set["workorder"]["rfcCi"]["ciAttributes"]["dhclient"] = node.workorder.ci.ciAttributes.dhclient
node.set["vmhostname"] = node.workorder.box.ciName+'-'+node.workorder.cloud.ciId.to_s+'-'+node.workorder.ci.ciName.split('-').last.to_i.to_s+'-'+ node.workorder.ci.ciId.to_s
node.set["full_hostname"] = node["vmhostname"]+'.'+node["customer_domain"]

# run the network script
include_recipe "os::network"