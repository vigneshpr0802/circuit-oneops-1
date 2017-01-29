#join windows domain if service exists otherwise just change hostname
if node[:workorder][:services].has_key?("windows-domain")

  cloud_name = node[:workorder][:cloud][:ciName]
  domain = node[:workorder][:services]["windows-domain"][cloud_name][:ciAttributes]
  ps_code = "$domain = '#{domain[:domain]}'
  $password = '#{domain[:password]}'| ConvertTo-SecureString -asPlainText -Force
  $username = '#{domain[:domain]}\\#{domain[:username]}'
  $credential = New-Object System.Management.Automation.PSCredential($username,$password)
  $newname = '#{node.vmhostname}'
  Rename-Computer -NewName $newname -Force
  Add-Computer -DomainName $domain -Credential $credential -Force -Options JoinWithNewName
  Start-Sleep -s 10"

  execute 'mkpasswd-oneops' do
    command 'mkpasswd -l -u oneops > /etc/passwd'
	action :nothing
  end
  
  powershell_script 'Join-Domain' do
    code ps_code
    not_if '(gwmi win32_computersystem).partofdomain'
	notifies :run, 'execute[mkpasswd-oneops]', :before
  end
else
  #rename windows VM
  powershell_script 'Rename-Computer' do
    code "Rename-Computer -NewName '#{node[:vmhostname]}'"
    not_if "hostname | grep #{node.vmhostname}"
  end
end


#restart
ruby_block 'declare-restart' do
  block do
    puts "***REBOOT_FLAG***"
	#puts "wrong reboot flag"
  end
  action :nothing
  subscribes :run, 'powershell_script[Rename-Computer]'
  subscribes :run, 'powershell_script[Join-Domain]'
end
  
reboot 'perform-restart' do
  action :reboot_now
  subscribes :run, 'ruby_block[declare-restart]'
end  