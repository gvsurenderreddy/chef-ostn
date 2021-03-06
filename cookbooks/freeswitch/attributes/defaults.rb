default[:freeswitch][:git_uri] = "git://git.freeswitch.org/freeswitch.git"
default[:freeswitch][:release_tag] = "2ab1605a8887adc62be1b75f6ef67af87ff080de"
default[:freeswitch][:inbound_proxy_media] = "true"
default[:freeswitch][:inbound_bypass_media] = "false"
default[:freeswitch][:sip_tls_version] = "sslv23"
default[:freeswitch][:service] = "freeswitch"
default[:freeswitch][:user] = "freeswitch"
default[:freeswitch][:group] = "freeswitch"
default[:freeswitch][:enabled] = "true"
default[:freeswitch][:path] = "/usr/local/freeswitch/bin"
default[:freeswitch][:homedir] = "/usr/local/freeswitch"
default[:freeswitch][:tls_only] = "true"
default[:freeswitch][:domain] = node[:fqdn]
