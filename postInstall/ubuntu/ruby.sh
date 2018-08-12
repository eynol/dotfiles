#!/bin/sh

if [ ! $(which ruby) ]
then 
  gpg --keyserver hkp://pgp.mit.edut --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
  sudo apt-add-repository -y ppa:rael-gc/rvm
  sudo apt-get update
  sudo apt-get install rvm
	source /etc/profile.d/rvm.sh
	rvm install ruby
  #sudo install ruby -y
else 
  echo "Ruby[installed]"
fi
cat <<EOF
  * First you need to add all users that will be using rvm to 'rvm' group,
      and logout - login again, anyone using rvm will be operating with `umask u=rwx,g=rwx,o=rx`.

        * To start using RVM you need to run `source /etc/profile.d/rvm.sh`
            in all your open shell windows, in rare cases you need to reopen all shell windows.
EOF
