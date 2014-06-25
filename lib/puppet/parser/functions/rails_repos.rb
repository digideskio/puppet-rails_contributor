require 'octokit'

module Puppet::Parser::Functions
  newfunction(:rails_repos, :type => :rvalue) do |args|
    repos_per_page = 100

    token = Facter.value('github_token')

    if token
      client = Octokit::Client.new(:access_token => token)
    else
      client = Octokit::Client.new
    end

    repo_count = client.org(:rails).public_repos
    pages = (repo_count / repos_per_page.to_f).round
    repos = []

    opts = { :per_page => repos_per_page }

    pages.times do |page|
      opts[:page] = page + 1
      repos.concat client.org_repos(:rails, opts).map(&:name)
    end

    repos.uniq
  end
end
