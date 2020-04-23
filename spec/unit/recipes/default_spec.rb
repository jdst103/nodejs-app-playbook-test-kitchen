require 'spec_helper'

it 'converges successfully' do
  expect { chef_run }.to_not raise_error
end

it "run get_update" do
  expect(chef_run).to update_apt_update 'update_sources'
end

it 'should install nginx' do
  expect(chef_run).to install_package "nginx"
end

it 'enables the nginx service' do
  expect(chef_run).to enable_service "nginx"
end

it 'start the nginx' do
  expect(chef_run).to start_service "nginx"
end

it 'should install nodejs from my recipe' do
  expect(chef_run).to include_recipe("nodejs")
end
it'should install pm2 via npm' do
  expect(chef_run).to install_nodejs_npm('pm2')
end
it'should create a proxy.conf template in /etc/nginx/sites-available' do
  expect(chef_run).to create_template('/etc/nginx/sites-available/proxy.conf').with_variables(proxy_port: 3000)
end


it 'should delete original link of /etc/nginx/sites-enabled/default' do
  expect(chef_run).to delete_link('/etc/nginx/sites-enabled/default')
end

it 'should create a symbolic link between /etc/nginx/sites-available and /etc/nginx/sites-enabled' do
  expect(chef_run).to create_link('/etc/nginx/sites-enabled/proxy.conf').with(to: '/etc/nginx/sites-available/proxy.conf')
end
