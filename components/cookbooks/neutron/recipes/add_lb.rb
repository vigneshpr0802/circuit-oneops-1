require File.expand_path('../../libraries/models/lbaas/loadbalancer_model', __FILE__)
require File.expand_path('../../libraries/models/lbaas/listener_model', __FILE__)
require File.expand_path('../../libraries/models/lbaas/pool_model', __FILE__)
require File.expand_path('../../libraries/models/lbaas/member_model', __FILE__)
require File.expand_path('../../libraries/models/lbaas/health_monitor_model', __FILE__)
require File.expand_path('../../libraries/models/tenant_model', __FILE__)
require File.expand_path('../../libraries/loadbalancer_manager', __FILE__)
require File.expand_path('../../libraries/network_manager', __FILE__)


def initialize_health_monitor(iprotocol, ecv_map, lb_name)
  ecv = ecv_map.tr('"', '').tr('{}', '')
  ecv_port, ecv_path = ecv.split(':', 2)
  ecv_method, ecv_url = ecv_path.split(' ', 2)

  health_monitor = HealthMonitorModel.new(iprotocol, 5, 2, 3)
  health_monitor.label.name=lb_name + '-ecv'
  health_monitor.http_method=ecv_method
  health_monitor.url_path=ecv_url

  return health_monitor
end

def initialize_members(subnet_id, protocol_port)
  members = Array.new
  computes = node[:workorder][:payLoad][:DependsOn].select { |d| d[:ciClassName] =~ /Compute/ }
  computes.each do |compute|
    ip_address = compute["ciAttributes"]["private_ip"]
    member = MemberModel.new(ip_address, protocol_port, subnet_id)
    members.push(member)
  end

  return members
end

def initialize_pool(iprotocol, lb_algorithm, lb_name, members, health_monitor, stickiness, persistence_type)
  pool = PoolModel.new(iprotocol, lb_algorithm)
  pool.label.name=lb_name + '-pool'
  pool.members=members
  pool.health_monitor=health_monitor

  if stickiness == 'true'
    session_persistence = SessionPersistenceModel.new(persistence_type)
    pool.session_persistence = session_persistence.serialize_optional_parameters
  end

  return pool
end

def initialize_listener(vprotocol, vprotocol_port, lb_name, pool)
  listener = ListenerModel.new(vprotocol, vprotocol_port)
  listener.label.name=lb_name + '-listener'
  listener.pool=pool

  return listener
end

def initialize_loadbalancer(vip_subnet_id, provider, lb_name, listeners)
  loadbalancer = LoadbalancerModel.new(vip_subnet_id, provider)
  loadbalancer.label.name = lb_name
  loadbalancer.listeners=listeners

  return loadbalancer
end

#-------------------------------------------------------
lb_attributes = node[:workorder][:rfcCi][:ciAttributes]
cloud_name = node[:workorder][:cloud][:ciName]
service_lb = node[:workorder][:services][:lb][cloud_name]
service_lb_attributes = node[:workorder][:services][:lb][cloud_name][:ciAttributes]
tenant = TenantModel.new(service_lb_attributes[:endpoint],service_lb_attributes[:tenant],
                         service_lb_attributes[:username],service_lb_attributes[:password])
service_compute_attributes = node[:workorder][:services][:compute][cloud_name][:ciAttributes]
stickiness = lb_attributes[:stickiness]
persistence_type = lb_attributes[:persistence_type]
subnet_name = service_lb_attributes[:subnet_name]
network_manager = NetworkManager.new(tenant)
subnet_id = network_manager.get_subnet_id(subnet_name)

lb_name = ''
listeners = Array.new
#loadbalancers array contains a list of listeners from lb::build_load_balancers
node.loadbalancers.each do |loadbalancer|
  lb_name = loadbalancer[:name]
  vprotocol = loadbalancer[:vprotocol]
  vport = loadbalancer[:vport]
  iprotocol = loadbalancer[:iprotocol]
  iport = loadbalancer[:iport]
  sg_name = loadbalancer[:sg_name]

  if vprotocol == 'HTTPS' and iprotocol == 'HTTPS'
    health_monitor = initialize_health_monitor('TCP', lb_attributes[:ecv_map], lb_name)
  else
    health_monitor = initialize_health_monitor(iprotocol, lb_attributes[:ecv_map], lb_name)
  end

  members = initialize_members(subnet_id, iport)
  pool = initialize_pool(iprotocol, lb_attributes[:lbmethod], lb_name, members, health_monitor, stickiness, persistence_type)
  listeners.push(initialize_listener(vprotocol, vport, lb_name, pool))
end
loadbalancer = initialize_loadbalancer(subnet_id, service_lb_attributes[:provider], lb_name, listeners)

lb_manager = LoadbalancerManager.new(tenant)
Chef::Log.info("Creating Loadbalancer..." + lb_name)
start_time = Time.now
Chef::Log.info("start time " + start_time.to_s)
loadbalancer_id = lb_manager.create_loadbalancer(loadbalancer)
Chef::Log.info("end time " + Time.now.to_s)
total_time = Time.now - start_time
Chef::Log.info("Total time to create " + total_time.to_s)

lb = lb_manager.get_loadbalancer(loadbalancer_id)
node.set[:lb_dns_name] = lb.vip_address
Chef::Log.info("VIP Address: " + lb.vip_address.to_s)
Chef::Log.info("Exiting neutron-lbaas add recipe.")
