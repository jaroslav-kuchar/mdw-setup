# MDW Setup
# @author Jaroslav Kuchař

# update list
bash "update" do
  user "root"
  code <<-EOH  		
	apt-get update		
  EOH
end

# Desktop Environment
package "xfce4"

# Chrome
package "chromium-browser"

# # Generate scripts
# execute "generate scripts" do
# 	cwd "/vagrant/oracle_scripts/"
# 	command "./generate_scripts.sh"
# 	user "vagrant"
# end

# # WLS
# execute "wls" do
# 	command "/vagrant/oracle_scripts/wls-silent.sh > /vagrant/oracle_scripts/wls-silent.lof"
# 	user "root"
# 	not_if { ::File.exists?("/vagrant/oracle_mw/wlserver")}
# end

# # OSB
# execute "osb" do
# 	command "/vagrant/oracle_scripts/osb-silent.sh > /vagrant/oracle_scripts/osb-silent.log"
# 	user "vagrant"
# 	not_if { ::File.exists?("/vagrant/oracle_mw/Oracle_OSB1")}
# end

# # Domain
# execute "domain" do
# 	command "/vagrant/oracle_scripts/wls-domain.sh > /vagrant/oracle_scripts/wls-domain.log"
# 	user "vagrant"
# 	not_if { ::File.exists?("/vagrant/oracle_mw/user_projects/domains/base_domain/startWebLogic.sh")}
# end