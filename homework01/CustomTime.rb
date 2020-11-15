class CustomTime
  def now
    Time.now
  end

  def friday?
    Time.now.friday?
  end

  def zone
    Time.now.zone
  end
end

mytime = CustomTime.new
puts(mytime.now)
puts(mytime.friday?)
puts(mytime.zone)