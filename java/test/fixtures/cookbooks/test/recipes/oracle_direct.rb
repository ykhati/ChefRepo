node.default['java']['jdk_version'] = '8'
node.default['java']['oracle']['accept_oracle_download_terms'] = true

include_recipe 'test_java::base'
include_recipe 'java::oracle'
include_recipe 'test_java::java_cert'
