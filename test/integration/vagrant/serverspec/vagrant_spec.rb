require 'serverspec'

describe package('git') do
  it { should be_installed }
end

describe package('mysql-server') do
  it { should be_installed }
end

describe "Mysql Daemon" do

  it "is listening on port 3306" do
    expect(port(3306)).to be_listening
  end

  it "has a running service of mysql" do
    expect(service("mysqld")).to be_running
  end

end

describe command("echo 'show databases;' | mysql -u root -p {{ mysql_pass }} ") do
  its(:stdout) { should match /dbase/ }
end
