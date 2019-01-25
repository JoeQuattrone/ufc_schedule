class CustomError < StandardError
  begin
    raise OpenURI::HTTPError

  rescue OpenURI::HTTPError: => e
    puts "#{e.class.name} #{e.message}"
    puts "Sorry the UFC API is unavailable, please try again later"
    puts "#{e.backtrace}"
end
