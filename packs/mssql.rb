include_pack 'genericdb'

name 'mssql'
description 'MS SQL Server'
type 'Platform'
category 'Database Relational SQL'

platform :attributes => {'autoreplace' => 'false'}

environment 'single', {}

resource 'secgroup',
         :cookbook => 'oneops.1.secgroup',
         :design => true,
         :attributes => {
             "inbound" => '[ "22 22 tcp 0.0.0.0/0", "1433 1433 tcp 0.0.0.0/0", "3389 3389 tcp 0.0.0.0/0"]'
         },
         :requires => {
             :constraint => '1..1',
             :services => "compute"
         }


resource 'mssql',
  :cookbook => 'oneops.1.mssql',
  :design   => true,
  :requires => {
    :constraint => '1..1',
	:services   => 'mirror'
  }
  
resource 'compute',
  :cookbook => 'oneops.1.compute',
  :attributes => { 'size'    => 'M-WIN' }

resource 'volume',
  :cookbook => 'oneops.1.volume',
  :attributes => { 'mount_point'    => 'Z' }
  
resource 'os',
  :cookbook => 'oneops.1.os',
  :design => true,
  :requires => { 
    :constraint => '1..1',
	:services   => 'compute,*mirror,*ntp,*windows-domain'
	},
  :attributes => {
	:ostype => 'windows_2012_r2'
  }

resource 'dotnetframework',
  :cookbook     => 'oneops.1.dotnetframework',
  :design       => true,
  :requires     => {
    :constraint => '1..1',
    :help       => 'Installs .net frameworks',
    :services   => '*mirror'
  },
  :attributes   => {
    :chocolatey_package_source   => 'https://chocolatey.org/api/v2/',
    :dotnet_version_package_name => '{ ".Net 4.6":"dotnet4.6", ".Net 3.5":"dotnet3.5" }'
  }  
  
[ 
  { :from => 'mssql', :to => 'dotnetframework' },
  { :from => 'dotnetframework', :to => 'os' },
  { :from => 'database', :to => 'mssql' } 
].each do |link|
  relation "#{link[:from]}::depends_on::#{link[:to]}",
    :relation_name => 'DependsOn',
    :from_resource => link[:from],
    :to_resource   => link[:to],
    :attributes    => { "flex" => false, "min" => 1, "max" => 1 }
end

[ 'mssql', 'dotnetframework', 'volume', 'os' ].each do |from|
  relation "#{from}::managed_via::compute",
    :except => [ '_default' ],
    :relation_name => 'ManagedVia',
    :from_resource => from,
    :to_resource   => 'compute',
    :attributes    => { }
end
