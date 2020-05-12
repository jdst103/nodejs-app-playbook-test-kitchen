# Integration testing on a Nodejs APP provisioned by Ansible using Test Kitchen (INSPEC).

Test kitchen spins up a VM and provisions the VM using the playbook in the root directory app.yml. This playbook calls two roles nginx and nodejs containing our tasks.

### the test consists of:
- nginx to be running and enabled
- expect http status error code 502
- nodejs to be installed
- nodejs version > 8
- pm2 installed

## SETUP HELP

NOTE:
the VM is configured with ubuntu 16.04 and uses a ubuntu/xenial vm box.

### TO download Test Kitchen, CHEFDK was installed. which included the tool INSPEC to run our integration test.

 If a mac/linux user, run this command to make sure you a running the default ruby version (ignore if windows)
````
echo 'eval "$(chef shell-init bash)"' >> ~/.bash_profile && source ~/.bash_profile
````

In order for your test to work with Ansible, you have to install the kitchen-ansible gem on your machine.
````
gem install kitchen-ansible
````

### tests/integration/default/sample.rb - contains our integration test created in ruby

test/integration/default is where you'll save your test files to.
chefignore is where you ignore chef related files.
kitchen.yml: This file describes your testing configuration, which is what you want to test and the target platforms.


#### appended in kitchen.yml:

tells Test kitchen to provision the VM using a specific playbook.
defines location of integration test.

````
provisioner:
  name: ansible_playbook
  hosts: test-kitchen
  playbook: ./app.yml

verifier:
  name: inspec

platforms:
  - name: ubuntu-16.04
    verifier:
    inspec_tests:
      - test/integration/default
    driver:
    box: ubuntu/xenial64
````

To run the integration test using locally, we use the kitchen.yml defining vagrant as our driver. (Vagrant and Virtual Box needs to be installed)

the command to spin up the local VM and test.
````
kitchen test
````
the command destroy the VM:
````
kitchen destroy
````

To run the integration test on a AWS instance, we use the kitchen.cloud.yml with information on the AWS instance linked to my personal AWS account:

the command to spin up the AWS instance and test.
````
KITCHEN_YAML=kitchen.cloud.yml kitchen test
````

the command to destroy the AWS resources.
````
KITCHEN_YAML=kitchen.cloud.yml kitchen destroy
````

## PACKER

Creates an image from an instance that has stable test results to be used to spin up the production environment.

run the command:
````
packer build packerapp.json
````

 This file provisions a ubuntu xenial 16.04 AMI (owner is amazon) with the playbook 'app.yml'. The JS app (AppFolder) is then synced onto the instance. Packer converts this temporary instance to an image.

 the source_ami_filter finds the ami id on amazon to base our configurations for this temporary instance. once the AMI is created, this temporary instance is deleted.
