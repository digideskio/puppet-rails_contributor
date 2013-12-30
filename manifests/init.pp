# Public: Configure a development environment to contribute to the Rails project
#
# Usage:
#
#   include rails_contributor
#   # or
#   class { 'rails_contributor': repositories => ['rails', 'arel'] }
class rails_contributor($repositories = rails_repos()) {
  include boxen::config

  $dir = "${boxen::config::srcdir}/rails"

  include postgresql
  include mysql
  include ruby::1_9_3
  include ruby::2_0_0

  file { $dir:
    ensure => directory
  }

  rails_contributor::project { $repositories: }

  file { "${dir}/rails/activerecord/test/config.yml":
    ensure  => present,
    source  => 'puppet:///modules/rails_contributor/config.yml',
    require => Rails_Contributor::Project['rails']
  }
}
