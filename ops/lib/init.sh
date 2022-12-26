ruby_version=3.0.0

install_rvm()
{
  sudo yum install gcc
  sudo yum install -y libyaml-devel autoconf gcc-c++ readline-devel zlib-devel openssl-devel
  curl -sSL https://get.rvm.io | bash
}

install_ruby()
{
  rvmsudo rvm install $ruby_version
  rvm use $ruby_version --default
}

install_rvm
install_ruby
