
storage_cloud_name = node[:workorder][:cloud][:ciName]
storagecloud = node[:workorder][:services][:storage][storage_cloud_name][:ciAttributes]
volumetype_map= JSON.parse(storagecloud[:volumetypemap]) if !storagecloud[:volumetypemap].nil?

if volumetype_map.count == 0
  node.set[:volume_type_from_map] = ""
  return true
end

# Get the volume type from the volume type map
volume_type_selected = node.workorder.rfcCi.ciAttributes["volume_type"]
Chef::Log.debug("node_lookup volume_type_selected: #{volume_type_selected}")
if volumetype_map[volume_type_selected] != nil
   node.set[:volume_type_from_map] = volumetype_map[volume_type_selected]
else
	exit_with_error("Volume Type #{volume_type_selected} Not found")
end
