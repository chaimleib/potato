class DueDate < ActiveRecord::Base
  # BRANCH_RGX = /\A(?:master|[0-9]{3}_(?:[0-9]+_)*release)\z/
  # BRANCH_ERR = "should be either 'master' or something like '013_0_1_release'"
  # VERSION_RGX = /\Av[1-9][0-9]*(?:\.(?:0|[1-9][0-9]*)){2,3}\z/
  # VERSION_ERR = "should begin with a 'v' and use periods to separate version segments, like 'v13.0.1'"
  DATE_RGX = %r{\A(?:0[1-9]|1[0-2])/(?:0[1-9]|[12][0-9]|3[01])/(?:19|20)(?:[0-9]{2})\z}
  DATE_ERR = "should use MM/DD/YYYY format, like 03/30/2016"
  
  validates :branch_name, 
    presence: true
  validates :due,
    format: {with: DATE_RGX, message: DATE_ERR}

  def self.for_version(version)
    dd = find_by(branch_name: version)
    return nil if dd.nil?
    Time.strptime dd.due, '%m/%d/%Y'
  end
end
