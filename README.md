### mac user did thus make sure default ruby version
echo 'eval "$(chef shell-init bash)"' >> ~/.bash_profile && source ~/.bash_profile

#saying this is going to provision with this playbool

test/integration/default is where you'll save your test files to.
chefignore is where you ignore chef related files, but you won't be using it in this tutorial.
kitchen.yml: This file describes your testing configuration, which is what you want to test and the target platforms.

In order for your test to work with Ansible, you have to install the kitchen-ansible gem on your machine.

gem install kitchen-ansible



crear dir tests/integration/default/sample.rb
our integration tests written in ruby

created roles/nodejs/tasks
have main file in root directory for abstractiom and easy to share


----appended in kitchen.yml

- name: ubuntu-18.04
    driver:
    box: ubuntu/xenial64
  verifier:
      inspec_tests:
        - test/integration/default





        https://deb.nodesource.com/node_8.x xenial/main amd64 nodejs amd64 8.17.0-1nodesource1 [14.1 MB]
