name                'Fuse'
description         'Installs/Configures Confluent Kafka'
version             '0.1'
maintainer          'OneOps'
maintainer_email    'support@oneops.com'
license             'Apache License, Version 2.0'


grouping 'default',
         :access => 'global',
         :packages => ['base', 'mgmt.catalog', 'mgmt.manifest', 'catalog', 'manifest', 'bom']

attribute 'user',
		  :description =>'App user',
		  :required =>'required',
		  :default => 'user',
		  :format => {
		  	:important =>true,
		  	:help => 'User is needed for fuse',
		  	:category => '1.Source',
		  	:order => 1
		  }

attribute 'password',
          :description => 'App password',
          :required => 'required',
          :default => 'password',
          :format => {
              :important => true,
              :help => 'Passoword is needed for fuse user',
              :category => '1.Source',
              :order => 1
          }

attribute 'group',
		  :description => 'group',
		  :required =>'required',
		  :default => 'user',
		  :format => {
		  	:important =>true,
		  	:help => 'Group is needed for fuse',
		  	:category => '1.Source',
		  	:order => 1
		  }

attribute 'filename',
		  :description => 'filename',
		  :required =>'required',
		  :default => 'jboss-fuse-6.1.0.redhat-328',
		  :format => {
		  	:important =>true,
		  	:help => 'filename is needed for fuse',
		  	:category => '1.Source',
		  	:order => 1
		  }

attribute 'url',
		  :description => 'url',
		  :required =>'required',
		  :default => 'http://192.168.0.1',
		  :format => {
		  	:important =>true,
		  	:help => 'url is needed for fuse',
		  	:category => '1.Source',
		  	:order => 1
		  }

attribute 'dir',
		  :description => 'file directory',
		  :required =>'required',
		  :default => '/opt',
		  :format => {
		  	:important =>true,
		  	:help => 'File directory is needed for fuse',
		  	:category => '1.Source',
		  	:order => 1
		  }

attribute 'role',
		  :description => 'Role ',
		  :required =>'required',
		  :default => 'admin',
		  :format => {
		  	:important =>true,
		  	:help => 'Role is needed for fuse',
		  	:category => '1.Source',
		  	:order => 1
		  }
attribute 'java home',
      :description => 'Proxy ',
      :required =>'required',
      :default => '/usr/lib/jvm/java',
      :format => {
        :important =>true,
        :help => 'Provide exact java home',
        :category => '3.Java Configuration',
        :order => 1
      }
attribute 'proxy',
		  :description => 'Proxy ',
		  :required =>'required',
		  :default => 'nill',
		  :format => {
		  	:important =>true,
		  	:help => 'Host is needed for maven settings.xml',
		  	:category => '2.Maven Configuration',
		  	:order => 1
		  }

attribute 'proxy_port',
		  :description => 'Proxy port ',
		  :required =>'required',
		  :default => 'nill',
		  :format => {
		  	:important =>true,
		  	:help => 'port is needed for maven settings.xml',
		  	:category => '2.Maven Configuration',
		  	:order => 1
		  }

attribute 'noproxy',
		  :description => 'No proxy ',
		  :required =>'required',
		  :default => 'nill',
		  :format => {
		  	:important =>true,
		  	:category => '2.Maven Configuration',
		  	:order => 1
		  }


attribute 'version',
          :description => 'Select version to Install',
          :required => 'required',
          :default => '1',
          :format => {
              :important => true,
              :help => 'Fuse Version',
              :category => '1.Source',
              :order => 3,
              :form => {'field' => 'select', 'options_for_select' => [
			['6.0.0','6.0.0'],['6.1.0','6.1.0'],['6.1.1','6.1.1'],['6.2.0','6.2.0'],
			['6.2.1','6.2.1'],['6.3.0','6.3.0']


]}
          }
=begin

attribute 'flavor',
          :description => 'Flavor',
          :required => 'required',
          :default => 'openjdk',
          :format => {
              :important => true,
              :help => 'The flavor of Java to use.',
              :category => '1.Source',
              :order => 1,
              :form => {:field => 'select', :options_for_select => [['Oracle JavaC', 'oracle'], ['OpenJDK', 'openjdk']]}
          }

attribute 'jrejdk',
          :description => 'Package Type',
          :required => 'required',
          :default => 'jdk',
          :format => {
              :important => true,
              :help => 'Java package type to be installed. Server JRE support is only for Java 7 or later',
              :category => '1.Source',
              :order => 2,
              :form => {:field => 'select', :options_for_select => [['JRE', 'jre'], ['JDK', 'jdk'], ['Server JRE', 'server-jre']]}
       }
 

attribute 'platformversion',
          :description => 'Select Platform version to Install',
          :required => 'required',
          :default => '1',
          :format => {
              :important => true,
              :help => 'Platformversion',
              :category => '1.Source',
              :order => 3,
              :form => {:field => 'select', :options_for_select => [
			['3.0', '3.0'],
 			['2.0', '2.0']


]}
          }

attribute 'packname',
          :description => 'Select type of confluent pack to install',
          :required => 'required',
          :default => 'confluent-platform',
          :format => {
              :important => true,
              :help => 'Selct pack name ',
              :category => '1.Source',
              :order => 3,
              :form => {:field => 'select', :options_for_select => [
			['confluent-platform', 'confluent-platform'],
			['confluent-kafka', 'confluent-kafka'],
 			['confluent-schema-registry', 'confluent-schema-registry'],
			['confluent-control-center', 'confluent-control-center']			


]}
          }



attribute 'scalaversion',
          :description => 'Select Scala Version to Install',
          :required => 'required',
          :default => '2',
          :format => {
              :important => true,
              :help => 'Scala Version',
              :category => '1.Source',
              :order => 3,
              :form => {:field => 'select', :options_for_select => [
			['2.10', '2.10'],
 			['2.11', '2.11'],
			['2.10.5', '2.10.5'],
 			['2.11.7', '2.11.7']

]}
          }


attribute 'zookeepernode',
          :description => 'Install Zookeeper Node Or Not ?',
          :required => 'required',
          :default => '2',
          :format => {
              :important => true,
              :help => 'Scala Version',
              :category => '1.Source',
              :order => 3,
              :form => {:field => 'select', :options_for_select => [
			['Yes', 'Yes'],
 			['No', 'No']
			

]}
          }



attribute 'zk_quorum_size',
    :description          => 'Zookeeper quorum size',
    :required => 'required',
    :default               => '3',
    :format => {
        :category => '1.Global',
        :help => 'The number of Kafka broker nodes that run Zookeeper electors. The rest of Kafka broker nodes runs Zookeeper observers',
        :order => 2,
     :form => {'field' => 'select', 'options_for_select' => [['3', '3'], ['5', '5']]}
}

attribute 'kafka_server_log_retention_days',
  :description          => 'Kafka Log4j retention days',
  :required => "required",
  :default               => '7',
  :format => {
    :category => '1.Global',
    :help => 'Days to retain Kafka Log4j log',
    :order => 3,
    :pattern => "[0-9]+"
}

attribute 'rolling_restart_max_tries',
:description          => 'Broker Rolling Restart: Maximum retries',
:required => "required",
:default               => '100',
:format => {
    :category => '1.Global',
    :help => 'Timeout = rolling_restart_max_tries * rolling_restart_sleep_time. If Kafka holds large amount of data, increase this number to give more tolerance (time) of rolling restart',
    :order => 4,
    :pattern => "[0-9]+"
}

attribute 'rolling_restart_sleep_time',
:description          => 'Broker Rolling Restart: Sleep time in sec of each retry',
:required => "required",
:default               => '30',
:format => {
    :category => '1.Global',
    :help => 'Timeout = rolling_restart_max_tries * rolling_restart_sleep_time. If Kafka holds large amount of data, increase this number to give more tolerance (time) of rolling restart',
    :order => 5,
    :pattern => "[0-9]+"
}

attribute 'show_kafka_properties',
    :description => "Show Kafka broker properties",
    :default => 'false',
    :format => {
        :category => '2.Kafka Configuration Parameters',
        :help => 'Check this box only if you want to view or change the Kafka broker properties',
        :order => 1,
        :form => {'field' => 'checkbox'}
}

attribute 'kafka_properties',
    :description => "Customimze server.proerties for Kafka configuration",
    :data_type => "hash",
    :default => '{"delete.topic.enable":"true","auto.create.topics.enable":"true","unclean.leader.election.enable":"false","controlled.shutdown.enable":"true","controlled.shutdown.max.retries":"3","controlled.shutdown.retry.backoff.ms":"5000","default.replication.factor":"1","offsets.topic.num.partitions":"200","offsets.topic.replication.factor":"3","offsets.retention.check.interval.ms":"600000","offsets.topic.replication.factor":"3","offsets.commit.timeout.ms":"5000","num.network.threads":"3","num.replica.fetchers":"2","num.io.threads":"8","socket.send.buffer.bytes":"8388608","socket.receive.buffer.bytes":"8388608","socket.request.max.bytes":"104857600","log.retention.hours":"4","log.retention.bytes":"10737418240","log.segment.bytes":"536870912","log.segment.bytes":"536870912","log.cleanup.policy":"delete","zookeeper.connection.timeout.ms":"6000","zookeeper.session.timeout.ms":"6000","zookeeper.sync.time.ms":"2000","queued.max.requests":"500","replica.lag.time.max":"10000","replica.fetch.wait.max.ms":"500","min.insync.replicas":"2","replica.fetch.max.bytes":"2097152","message.max.bytes":"2097152","replica.high.watermark.checkpoint.interval.ms":"5000","replica.socket.timeout.ms":"30000","replica.socket.receive.buffer.bytes":"65536"}',
    :format => {
        :important => true,
        :help => 'Customize Kafka config. Add new config if needed',
        :filter => {'all' => {'visible' => 'show_kafka_properties:eq:true'}},
        :category => '2.Kafka Configuration Parameters',
        :order => 2
}

attribute 'show_zk_properties',
    :description => "Show Zookeeper properties",
    :default => 'false',
    :format => {
        :category => '3.Zookeepr Configuration Parameters',
        :help => 'Check this box only if you want to view or change the Zookeeper related properties',
        :order => 1,
        :form => {'field' => 'checkbox'}
}

attribute 'zookeeper_properties',
:description => "Customim	ze zookeeper.properties for Zookeeper configuration",
:data_type => "hash",
:default => '{"clientPort":"9091","tickTime":"2000","initLimit":"10","syncLimit":"5","maxClientCnxns":"1000","maxSessionTimeout":"180000","autopurge.snapRetainCount":"3","autopurge.purgeInterval":"1"}',
:format => {
    :important => true,
    :help => 'Customize Zookeeper config. Add new config if needed',
    :filter => {'all' => {'visible' => 'show_zk_properties:eq:true'}},
    :category => '3.Zookeepr Configuration Parameters',
    :order => 2
}

attribute 'monitoring_system',
    :description => 'Monitoring System',
    :default => 'Ganglia',
    :required => 'required',
    :format => {
        :category => '4.Monitoring',
        :help => 'Choose Ganglia (deployed together with Kafka Console/Manager) or Graphite (need a separate instance) or Both (for RYG dashboard and existing Ganglia monitoring)',
        :order => 1,
        :form => {'field' => 'select', 'options_for_select' => [['Ganglia', 'Ganglia'],['Graphite', 'Graphite'], ['Both', 'Both']]}
}

attribute 'graphite_url',
    :description => 'Graphite URL (address:port)',
    :default => '# external_graphite_address:port, such as 10.1.2.3:2003 or www.graphite.com:2003 #',
    :format => {
        :help => 'External Graphite URL. A Graphtie cluster needs to be deployed and ready to use at this moment',
        :filter => {'all' => {'visible' => 'monitoring_system:neq:Ganglia'}},
        :category => '4.Monitoring',
        :order => 2
}

=end

recipe 'add', 'Install fuse'
