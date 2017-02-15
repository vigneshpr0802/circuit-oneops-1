name             'Mssql'
maintainer       'Oneops'
maintainer_email 'support@oneops.com'
license          'Apache License, Version 2.0'
description      'Installs/configures Microsoft SQL Server'
version          '0.1.0'

depends 'os'

grouping 'default',
  :access   => 'global',
  :packages => [ 'base', 'mgmt.catalog', 'mgmt.manifest', 'catalog', 'manifest', 'bom' ]

attribute 'version',
  :description => 'MS SQL Server version and edition',
  :default     => 'mssql_2014_enterprise',
  :format      => {
    :help      => 'Select version and edition of MS SQL Server to be installed',
    :category  => '1.Global',
    :order     => 1,
    :form => { 'field' => 'select', 'options_for_select' => [ ['2014 Enterprise', 'mssql_2014_enterprise'], ['2016 Enterprise', 'mssql_2016_enterprise'] ] }
	}

attribute 'password',
  :description => 'sa Password',
  :required => 'required',
  :encrypted => true,
  :default => 'mssql',
  :format => {
    :help => 'sa password used for administration of the MS SQL Server',
    :category => '1.Global',
    :order => 2
  }
