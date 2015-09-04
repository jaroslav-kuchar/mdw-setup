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
package "virtualbox-guest-dkms"
package "virtualbox-guest-utils"
package "virtualbox-guest-x11"
package "slim"

# vagrant reload

# Chrome
package "chromium-browser"

# Eclipse
remote_file '/tmp/eclipse-jee-mars-R-linux-gtk-x86_64.tar.gz' do
  source 'http://mirrors.nic.cz/eclipse/technology/epp/downloads/release/mars/R/eclipse-jee-mars-R-linux-gtk-x86_64.tar.gz'
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  action :create
  not_if { File.exist?('/home/vagrant/Desktop/eclipse/') }
end

execute 'extract_eclipse' do
  command 'mkdir /home/vagrant/Desktop && tar xzvf eclipse-jee-mars-R-linux-gtk-x86_64.tar.gz -C /home/vagrant/Desktop/'
  cwd '/tmp/'
  user 'vagrant'
  group 'vagrant'
  not_if { File.exists?("/home/vagrant/Desktop/eclipse/") }
end

# https://github.com/snowch/carbon-products-development-environment/blob/2aab91bbde6f2564f1b72f4908e881083519f560/scripts/desktop_setup.sh
bash "eclipse script" do
  user "vagrant"
  code <<-EOH  		
	echo '#!/bin/bash' >> /home/vagrant/Desktop/eclipse-start.sh
	echo 'export SWT_GTK3=0 && /home/vagrant/Desktop/eclipse/eclipse' >> /home/vagrant/Desktop/eclipse-start.sh
	chmod +x /home/vagrant/Desktop/eclipse-start.sh
  EOH
  not_if { File.exists?("/home/vagrant/Desktop/eclipse/eclipse-start.sh") }
end

bash "server script" do
  user "vagrant"
  code <<-EOH  		
	echo '#!/bin/bash' >> /home/vagrant/Desktop/server-start.sh
	echo 'x-terminal-emulator -e /vagrant/oracle_mw/user_projects/domains/base_domain/startWebLogic.sh && wait $!' >> /home/vagrant/Desktop/server-start.sh
	chmod +x /home/vagrant/Desktop/server-start.sh
  EOH
  not_if { File.exists?("/home/vagrant/Desktop/eclipse/server-start.sh") }
end

# http://mirrors.nic.cz/eclipse/technology/epp/downloads/release/mars/R/eclipse-jee-mars-R-linux-gtk-x86_64.tar.gz

# # Generate scripts
# execute "generate scripts" do
# 	cwd "/vagrant/oracle_scripts/"
# 	command "./generate_scripts.sh"
# 	user "vagrant"
# end

# # WLS
# execute "wls" do
# 	command "/vagrant/oracle_scripts/wls-silent.sh > /vagrant/oracle_scripts/wls-silent.log"
# 	user "root"
# 	not_if { ::File.exists?("/vagrant/oracle_mw/wlserver/common/bin/config.sh")}
# end

# # OSB
# execute "osb" do
# 	command "/vagrant/oracle_scripts/osb-silent.sh > /vagrant/oracle_scripts/osb-silent.log"
# 	user "vagrant"
# 	not_if { ::File.exists?("/vagrant/oracle_mw/Oracle_OSB1/install/setupinfo.txt")}
# end

# # Domain
# execute "domain" do
# 	command "/vagrant/oracle_scripts/wls-domain.sh > /vagrant/oracle_scripts/wls-domain.log"
# 	user "vagrant"
# 	not_if { ::File.exists?("/vagrant/oracle_mw/user_projects/domains/base_domain/startWebLogic.sh")}
# end
