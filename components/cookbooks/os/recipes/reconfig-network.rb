
# Set some metadata that's not available while in this
# procedure mode 

node.set["workorder"]["rfcCi"]["ciAttributes"]["hosts"] = "{}"
node.set["workorder"]["rfcCi"]["ciName"]  = node.workorder.ci.ciName
node.set["workorder"]["rfcCi"]["ciId"] = node.workorder.ci.ciId
node.set["workorder"]["rfcCi"]["ciAttributes"]["additional_search_domains"] = node.workorder.ci.ciAttributes.additional_search_domains
node.set["workorder"]["rfcCi"]["ciAttributes"]["dhclient"] = node.workorder.ci.ciAttributes.dhclient

# run the network script
include_recipe "os::network"