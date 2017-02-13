name             'Mssql'
maintainer       'Oneops'
maintainer_email 'support@oneops.com'
license          'Apache License, Version 2.0'
description      'Installs/configures Microsoft SQL Server'
version          '0.1.0'

#supports 'windows'
depends 'os'

grouping 'default',
  :access   => "global",
  :packages => [ 'base', 'mgmt.catalog', 'mgmt.manifest', 'catalog', 'manifest', 'bom' ]

attribute 'version',
  :description => "MS SQL Server version and edition",
  :default     => "2014_enterprise",
  :format      => {
    :help      => 'Select version and edition of MS SQL Server to be installed',
    :category  => '1.Global',
    :order     => 1,
    :form => { 'field' => 'select', 'options_for_select' => [ ['2014 Express', '2014_express'], ['2014 Standard', '2014_standard'], ['2014 Enterprise', '2014_enterprise'] ] }
	}

attribute 'url',
  :description => 'Installation Media URL',
  :format      => {
    :help      => 'URL for the MS SQL Server installation media',
    :category  => '1.Global',
    :order     => 2
  }


attribute 'password',
  :description => "sa Password",
  :required => "required",
  :encrypted => true,
  :default => "mssql",
  :format => {
    :help => 'sa password used for administration of the MS SQL Server',
    :category => '1.Global',
    :order => 3
  }