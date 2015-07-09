(function() {
  var baseUri, common, jiraUriBase, propagations, root;

  root = this;

  root.formatters = new Object;

  root.sorters = new Object;


  /* FORMATTERS */

  root.formatters.common = common = new Object;

  root.formatters.propagations = propagations = new Object;

  baseUri = location.protocol + '//' + location.host + location.pathname;

  if (document.context) {
    jiraUriBase = document.context.jira_host + '/browse/';
  }

  common.relDueDate = function(dateString) {
    var date, friendly, iso, now, tag, timeClasses;
    if (!dateString) {
      return "N/A";
    }
    date = new Date(dateString);
    now = new Date;
    iso = strftime('%Y-%m-%dT%H:%M:%S.%L%z', date);
    friendly = strftime('%A, %B %-d, %Y %-I:%M %P %z', date);
    timeClasses = ['timeago', 'due'];
    if (date < now) {
      timeClasses.push('urgent');
    }
    tag = document.createElement('time');
    tag.setAttribute('class', timeClasses.join(' '));
    tag.setAttribute('datetime', iso);
    tag.setAttribute('title', friendly);
    tag.setAttribute('data-time-ago', iso);
    tag.innerHTML = friendly;
    return tag.outerHTML;
  };

  common.jiraIssue = function(key) {
    var escapedKey, tag;
    tag = document.createElement('a');
    escapedKey = encodeURIComponent(key);
    tag.setAttribute('href', jiraUriBase + escapedKey);
    tag.innerHTML = key.replace('-', '&#8209;');
    return tag.outerHTML;
  };

  common.pr = function(pr) {
    var tag;
    tag = document.createElement('a');
    tag.setAttribute('href', pr.uri);
    tag.innerHTML = pr.key.replace('-', '&#8209;');
    return tag.outerHTML;
  };

  common.prs = function(prs) {
    var links;
    if (!prs || prs.length === 0) {
      return '-';
    }
    prs = prs.sort(function(a, b) {
      var aDate, bDate;
      aDate = new Date(a.date);
      bDate = new Date(b.date);
      if (aDate < bDate) {
        return -1;
      }
      if (aDate > bDate) {
        return 1;
      }
      return 0;
    });
    links = prs.map(common.pr).join(' ');
    return links;
  };

  propagations.user = function(userString) {
    var escapedUser, params, tag, uri;
    escapedUser = encodeURIComponent(userString);
    params = "?utf8=%E2%9C%93&user=" + escapedUser;
    uri = baseUri + params;
    tag = document.createElement('a');
    tag.setAttribute('href', uri);
    tag.innerHTML = userString;
    return tag.outerHTML;
  };

  propagations.targetVersion = function(version, row) {
    var due, isUrgent, now, tag;
    due = new Date(row.due);
    now = new Date;
    isUrgent = row.due && due < now;
    if (!isUrgent) {
      return version;
    }
    tag = document.createElement('span');
    tag.setAttribute('class', 'urgent');
    tag.innerHTML = version;
    return tag.outerHTML;
  };

}).call(this);
