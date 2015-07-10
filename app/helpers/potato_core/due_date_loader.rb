require 'potato_core/jira_adapter'
require 'potato_core/version_scraper'

class DueDateLoader
  TFORMAT = "%m/%d/%Y"
  WIKI_PATH = '/wiki/display/CP/CD+Maintenance+Releases'

  def self.load_tsv(fpath)
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

  def self.scrape_wiki
    jira = JiraAdapter.new
    html = jira.connection.submit_get WIKI_PATH
    data = VersionScraper.scrape_freeze_dates html
    result = {}
    data.each do |ver, date|
      next if date.nil?
      key = (ver =~ /\A[0-9]/) ? "v#{ver}" : ver
      result[key] = date
    end
    result
  end

  def self.update_db(data)
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

  def self.update_from_wiki(user)
    data = scrape_wiki
    update_db data
    ResourceUpdate.create(
      name: 'DueDates', 
      updated: Time.now, 
      source_uri: JiraAdapter.new.jira.options[:site] + WIKI_PATH,
      user: user
    )
  end
end
