describe service "nginx" do
  it { should be_running }
  it { should be_enabled }
end

describe http('http://localhost', enable_remote_worker: true) do
  its('status') { should cmp 502 }
end

describe package ('nodejs') do
  it { should be_installed }
  its('version') { should cmp > '8.*' }
end

describe npm ('pm2') do
  it { should be_installed }
end
