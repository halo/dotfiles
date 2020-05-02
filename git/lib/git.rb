require 'git/runtime'
require 'git/prompt'

require 'git/query/clean_working_tree'
require 'git/query/current_branch_name'
require 'git/query/initialized_repository'
require 'git/query/local_branches'
require 'git/query/merged_local_branches'

require 'git/cli/checkout_branch'
require 'git/cli/checkout_master'
require 'git/cli/safely_delete_branch'
require 'git/cli/force_delete_branch'

require 'git/requires/initialized_repository'
require 'git/requires/clean_working_tree'

require 'git/actions/cut'

module Git
  def self.master?
    branch_name == 'master'
  end

  def self.branch_name

  end
end
