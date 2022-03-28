module TimeFormatHelper
  def time_now
    Time.now.strftime('%b %e %Y %R')
  end
end
