class DueDate < ActiveRecord::Base
  # BRANCH_RGX = /\A(?:master|[0-9]{3}_(?:[0-9]+_)*release)\z/
  # BRANCH_ERR = "should be either 'master' or something like '013_0_1_release'"
  # VERSION_RGX = /\Av[1-9][0-9]*(?:\.(?:0|[1-9][0-9]*)){2,3}\z/
  # VERSION_ERR = "should begin with a 'v' and use periods to separate version segments, like 'v13.0.1'"
  # ISO8601_RGX = /\A(?:[1-9]\d{3}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1\d|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[1-9]\d(?:0[48]|[2468][048]|[13579][26])|(?:[2468][048]|[13579][26])00)-02-29)T(?:[01]\d|2[0-3]):[0-5]\d:[0-5]\d(?:Z|[+-][01]\d:[0-5]\d)\z/
  DATE_RGX = %r{\A(?:0[1-9]|1[0-2])/(?:0[1-9]|[12][0-9]|3[01])/(?:19|20)(?:[0-9]{2})\z}
  DATE_ERR = "should use MM/DD/YYYY format, like 03/30/2016"
  
  validates :branch_name, 
    presence: true
  validates :due,
    format: {with: DATE_RGX, message: DATE_ERR}

  def self.for_version(version)
    dd = find_by(branch_name: version)
    return nil if dd.nil?
    day = Time.strptime dd.due, '%m/%d/%Y'
    t_str = day.strftime '%Y-%m-%d 17:00:00.000-07:00'
    Time.parse t_str
  end
end
