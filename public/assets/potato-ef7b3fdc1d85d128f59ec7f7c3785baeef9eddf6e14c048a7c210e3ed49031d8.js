(function() {
  var baseUri, common, due_dates, elements, jiraIssueUriBase, jiraSessionUri, jiraUriBase, preload, propagations, root;

  root = this;

  root.potato = new Object;

  root.potato.elements = elements = new Object;

  elements.throbber = function() {
    var img;
    img = $('<img>', {
      src: '/assets/throbber.gif',
      alt: 'loading...',
      "class": 'throbber'
    });
    return img;
  };

  elements.tableThrobber = function() {
    var img;
    img = $('<img>', {
      src: '/assets/table-throbber.gif',
      alt: 'loading...',
      "class": 'table-throbber'
    });
    return img;
  };

  preload = $('body').append('<div>', {
    id: "preload",
    style: "display:none;"
  }).append(elements.throbber()).append(elements.tableThrobber());

  $(document).on('page:change', function() {
    return preload.remove();
  });

  $(document).on('pre-body.bs.table', function(event) {
    return $('#content .fixed-table-loading').html(elements.tableThrobber());
  });


  /* FORMATTERS */

  root.potato.formatters = new Object;

  root.potato.formatters.common = common = new Object;

  root.potato.formatters.propagations = propagations = new Object;

  root.potato.formatters.due_dates = due_dates = new Object;

  baseUri = location.protocol + '//' + location.host + location.pathname;

  if (document.context) {
    jiraUriBase = document.context.jira_host;
    jiraIssueUriBase = jiraUriBase + '/browse/';
    jiraSessionUri = jiraUriBase + '/rest/auth/1/session';
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
    tag.setAttribute('href', jiraIssueUriBase + escapedKey);
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

  due_dates.due = function(dueField) {
    var $due, $result, due_ref_link, due_ref_name;
    $due = $(dueField);
    $due.text($.trim($due.text()));
    due_ref_name = $due.attr('data-ref-name');
    if (!due_ref_name) {
      return $due.prop('outerHTML');
    }
    due_ref_link = $due.attr('data-ref-link');
    $result = $('<div>', {
      "class": "strong grey"
    });
    $result.append($('<a>', {
      href: due_ref_link,
      text: due_ref_name
    }));
    $result.append('&rarr;');
    $result.append($due);
    return $result.prop('outerHTML');
  };


  /* SORTERS */

  root.potato.sorters = new Object;

  root.potato.sorters.due_dates = due_dates = new Object;

  due_dates.due = function(a, b) {
    var $a, $b, dateA, dateB, nameA, nameB;
    $a = $('<div>').append(a).find('time');
    $b = $('<div>').append(b).find('time');
    dateA = $a.attr('datetime');
    dateB = $b.attr('datetime');
    if (dateA > dateB) {
      return 1;
    }
    if (dateA < dateB) {
      return -1;
    }
    nameA = $a.attr('data-ref-name');
    nameB = $b.attr('data-ref-name');
    if (nameA && !nameB) {
      return -1;
    }
    if (!nameA && nameB) {
      return 1;
    }
    if (nameA > nameB) {
      return 1;
    }
    if (nameA < nameB) {
      return -1;
    }
    return 0;
  };

}).call(this);
