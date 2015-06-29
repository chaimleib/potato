module ApplicationHelper
  def breakable_uri(uri, breaker='<wbr/>')
    temp = uri
    result = []
    schema = temp.match %r{\Ahttps?://}i
    if schema
      schema = schema[0]
      result.push schema
      temp = temp[schema.length..-1]
    end
    while (m = temp.match %r{\A[^/_%]+(?:/|_|%[0-9]{2})+}) do
      m = m[0]
      result.push m
      temp = temp[m.length..-1]
    end
    
    result.join breaker
  end
  
  def breakable_email(email, breaker='<wbr/>')
    temp = email
    result = []
    while (m = temp.match %r{\A[^/_%@]+(?:@|/|_|%[0-9]{2})+}) do
      m = m[0]
      result.push m
      temp = temp[m.length..-1]
    end
    
    result.join breaker
  end
end
