class DueDate < ActiveRecord::Base
  # BRANCH_RGX = /\A(?:master|[0-9]{3}_(?:[0-9]+_)*release)\z/
  # BRANCH_ERR = "should be either 'master' or something like '013_0_1_release'"
  # VERSION_RGX = /\Av[1-9][0-9]*(?:\.(?:0|[1-9][0-9]*)){2,3}\z/
  # VERSION_ERR = "should begin with a 'v' and use periods to separate version segments, like 'v13.0.1'"
  # ISO8601_RGX = /\A(?:[1-9]\d{3}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1\d|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[1-9]\d(?:0[48]|[2468][048]|[13579][26])|(?:[2468][048]|[13579][26])00)-02-29)T(?:[01]\d|2[0-3]):[0-5]\d:[0-5]\d(?:Z|[+-][01]\d:[0-5]\d)\z/
  DATE_RGX = %r{\A(?:0[1-9]|1[0-2])/(?:0[1-9]|[12][0-9]|3[01])/(?:19|20)(?:[0-9]{2})\z}
  DATE_ERR = "should use MM/DD/YYYY format, like 03/30/2016"

  belongs_to :due_ref, class_name: 'DueDate', foreign_key: :due_ref_id
  has_many :referencers, class_name: 'DueDate', foreign_key: :due_ref_id
  
  normalize :due do |val|
    if val.present?
      Time.strptime(val, '%m/%d/%Y').strftime('%m/%d/%Y')
    else
      nil
    end
  end

  validates :branch_name, 
    presence: true,
    uniqueness: true
  validates :due,
    allow_nil: true,
    format: {with: DATE_RGX, message: DATE_ERR}
  validates :resolve,
    presence: true
    
  validate :has_no_circular_refs

  def self.for_version(version)
    dd = find_by(branch_name: version)
    return nil if dd.nil?

    # t is time without time zone
    # TODO: get 17:00:00 from db
    t = Time.strptime "#{dd.resolve} 17:00:00" , "%m/%d/%Y %H:%M:%S"

    # apply config.time_zone
    Time.zone.local(t.year, t.month, t.day, t.hour, t.min, t.sec)
  end

  def resolve
    if self.due_ref_id.nil?
      return self.due
    end
    DueDate.find(self.due_ref_id).resolve
  end

  def due_ref_chain
    # returns a hash of all due_ref links, keyed by branch_name.
    # If there is a circular reference, the hash will have a nil
    # key assigned to the due_ref causing it.
    # a hash is used instead of a list so that membership tests
    # are constant time.
    cur = self
    visited = {}
    begin
      if visited.has_key? cur.branch_name
        visited[nil] = cur
        return visited
      end
      cur = visited[cur.branch_name] = cur.due_ref
    end while !cur.nil?
    visited
  end

  def has_no_circular_refs
    if due_ref_chain.has_key? nil
      errors.add(:due_ref_id, "has circular reference chain")
    end
  end
end
