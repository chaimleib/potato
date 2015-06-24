require 'potato_core/jira_adapter'
require 'potato_helper'
include PotatoHelper

class PotatoController < ApplicationController
  def overview
    pj = ensure_potato_jira session
    user = params[:user].present? ? params[:user] : pj.con.username
    
    data = get_task_list_by_version user, session, pj
    
    # order the data
    sorted_keys = data.keys.sort
    sorted_keys.delete('Unversioned')
    sorted_keys.unshift 'Unversioned' if data.has_key? 'Unversioned'

    @context = {
      :overview_table_rows => sorted_keys,
      :overview_table_data => data,
      :overview_username => user
    }
    
  end
end
