# Check if vault is located into specific path
describe file('/usr/local/bin/vault') do
  it { should exist }
end

# Check if command vault is available
describe command('vault') do
  it { should exist }
end
