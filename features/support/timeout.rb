def retry_on_timeout(n = 3, &block)
  block.call
rescue Exception => e
  if n > 0
    puts "Catched error: #{e.message}. #{n-1} more attempts."
    retry_on_timeout(n - 1, &block)
  else
    raise
  end
end