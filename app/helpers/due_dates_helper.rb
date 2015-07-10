module DueDatesHelper
  require 'potato_core/due_date_loader'
  require 'byebug' if Rails.env.development?

  def try_update_from_wiki(user, session, pj)
    context = {messages: []}
    begin
      resource_update = DueDateLoader.update_from_wiki user
      context[:messages] << {body: "Updated due dates as #{user.email}", class: 'success'}
    rescue Exception => e
      if Rails.env.development?
        byebug
      else
        context[:messages] << {body: e, class: 'error'}
        raise e
      end
    end
    context
  end
end
