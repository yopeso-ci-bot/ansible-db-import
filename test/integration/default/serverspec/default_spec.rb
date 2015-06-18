require 'serverspec'

describe user('portal') do
  it { should exist }
  it { should belong_to_group 'portal' }

end

describe package('postfix') do
  it { should be_installed }
end

describe port(25) do
  it { should be_listening }
end

describe service('postfix') do
  it { should be_enabled }
end

describe file('/etc/mailname') do
  its(:content) { should match /portal-mail-default.yopeso.com/ }
end

describe file('/etc/postfix/virtual') do
  its(:content) { should match /@portal-mail-default.yopeso.com portal/ }
end

describe file('/home/portal/Maildir') do
  it { should be_directory }
end

describe file('/etc/postfix/main.cf') do
  its(:content) { should match /mydestination = portal-mail-default.yopeso.com, localhost/ }
end

describe file('/etc/postfix/main.cf') do
  its(:content) { should match /myhostname = portal-mail-default.yopeso.com/ }
end

describe file('/etc/postfix/main.cf') do
  its(:content) { should match /mailbox_command =/ }
end

describe file('/etc/postfix/main.cf') do
  its(:content) { should match /virtual_alias_maps = hash:\/etc\/postfix\/virtual/ }
end

describe file('/etc/postfix/main.cf') do
  its(:content) { should match /home_mailbox = Maildir\// }
end

describe file('/etc/hostname') do
  its(:content) { should match /portal-mail-default.yopeso.com/ }
end
