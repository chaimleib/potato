require 'potato_core/jira_adapter'
require 'pry'
require 'pp'

TFORMAT = "%m/%d/%Y"

def load_tsv(fpath)
  fdata = File.open(fpath).readlines
  lines = fdata.map{|l| l.strip.split("\t")}
  lines.shift  # ignore column headings
  result = {}

  times = {  # time translation table
    'eos' => '07/02/2015',                 # end of sprint
    'now' => Time.now.strftime(TFORMAT),   # today
    'eow' => '07/02/2015'                  # end of week
  }

  lines.each{|l|
    branch = l[0]
    date = l[1].strip
    date = Time.strptime(times[date], TFORMAT)
    result[branch] = date
  }
  result
end

def update_db(data)
  data.each do |branch, time|
    dd = DueDate.find_by(branch_name: branch)
    if dd
      dd.due = time.strftime TFORMAT
      dd.save
    else
      dd = DueDate.create(
        branch_name: branch, 
        due: time.strftime(TFORMAT))
      dd.save
    end
  end
end

binding.pry
