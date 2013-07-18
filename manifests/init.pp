# Public: Configure a development environment to contribute to the Rails project
#
# Usage:
#
#   include rails_contributor
class rails_contributor {
  include boxen::config

  $dir = "${boxen::config::srcdir}/rails"

  include postgresql
  include mysql
  include ruby::1_8_7
  include ruby::1_9_3
  include ruby::2_0_0

  file { $dir:
    ensure => directory
  }

  $repos = rails_repos()
  rails_contributor::project { $repos: }

  file { "${dir}/rails/activerecord/test/config.yml":
    source  => 'puppet:///modules/rails_contributor/config.yml',
    ensure  => present,
    require => Rails_Contributor::Project['rails']
  }
}
