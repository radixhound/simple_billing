def retry_on_timeout(n = 20, &block)
  block.call
rescue Capybara::TimeoutError, Capybara::ElementNotFound => e
  if n > 0
    puts "Catched error: #{e.message}. #{n-1} more attempts."
    sleep(0.1) #stops it from timing out so easily on a slower computer
    retry_on_timeout(n - 1, &block)
  else
    raise
  end
end