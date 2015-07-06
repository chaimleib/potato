# POTATO: Programmer's Open Task AggregaTOr

POTATO is a developer tool to avoid the many clicks necessary to navigate JIRA issues. It pulls data from GitHub and JIRA to produce a checklist of job items that remain to be completed and how urgent they are.

The goal is to make an Atlassian dashboard gadget for JIRA. At the moment, it works as a Rails web app, with very basic functionality.

## Prerequisites

This app is tested using

* Ruby 2.1.5
* Rails 4.2.0
* MySQL 14.14 Distrib 5.6.25

## Setup

* `config/secrets.yml`: Copy `config/secrets.yml.template` and fill it in with your information.

* Run `bundle`

* Run `bower install`

* Run `mysql.server start`

* Run `rails server`

* Load in due dates. Either
	
	* Go to http://localhost:3000/due_dates and put them in manually, or

	* Use an automatic script to load them in, similar to `app/helpers/load_due_dates.rb`
