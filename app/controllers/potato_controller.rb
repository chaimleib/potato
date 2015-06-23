require 'date'

class PotatoController < ApplicationController
  def overview
    data = {
      'Unversioned' => {
        :tasks => 3,
        :time => nil
      },
      'v13.0.0.1' => {
        :tasks => 6,
        :time => '4 days'
      },
      'v12.0.1' => {
        :tasks => 1,
        :time => '2 days'
      }
    }
    sorted_keys = data.keys.sort
    sorted_keys.delete('Unversioned')
    sorted_keys.unshift 'Unversioned' if data.has_key? 'Unversioned'

    @context = {
      :overview_table_rows => sorted_keys,
      :overview_table_data => data
    }
  end
end
