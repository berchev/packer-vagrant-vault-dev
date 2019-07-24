# packer-vagrant-vault-dev
packer template used to build
- vagrant box(virtualbox and vmware_desktop providers) with vault tool installed.
- vault is going to run as a systemd service
- vault will listen on all IP addresses
- vault will have default root token (changeme)

# Requirements
- packer tool installed
- virtualbox installed
- vmware workstation installed

# Instructions:
- `git clone https://github.com/berchev/packer-vagrant-vault-dev.git`
- `cd packer-vagrant-vault-dev`
- `packer build vault-dev.json`

# Kitchen test results
```
Target:  ssh://vagrant@127.0.0.1:2200

  File /usr/local/bin/vault
     ✔  should exist
  Command: `vault`
     ✔  should exist

Test Summary: 2 successful, 0 failures, 0 skipped
       Finished verifying <default-vault-dev64-vbox> (0m0.69s).
-----> Setting up <default-vault-dev64-vmware>...
       Finished setting up <default-vault-dev64-vmware> (0m0.00s).
-----> Verifying <default-vault-dev64-vmware>...
[2019-07-24T11:36:33+03:00] WARN: DEPRECATION: InSpec Attributes are being renamed to InSpec Inputs to avoid confusion with Chef Attributes. Use --input-file on the command line instead of --attrs.
       Loaded tests from {:path=>".home.gberchev.spreadsheet.packer.packer-vagrant-vault-dev.test.integration.default"} 

Profile: tests from {:path=>"/home/gberchev/spreadsheet/packer/packer-vagrant-vault-dev/test/integration/default"} (tests from {:path=>".home.gberchev.spreadsheet.packer.packer-vagrant-vault-dev.test.integration.default"})
Version: (not specified)
Target:  ssh://vagrant@127.0.0.1:2201

  File /usr/local/bin/vault
     ✔  should exist
  Command: `vault`
     ✔  should exist

Test Summary: 2 successful, 0 failures, 0 skipped
       Finished verifying <default-vault-dev64-vmware> (0m0.99s).
-----> Kitchen is finished. (0m3.00s)
```

## TODO

