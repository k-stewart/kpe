# Reference:
# http://en.wikipedia.org/wiki/Cron
# Learn more: http://github.com/javan/whenever

every :sunday, at: "2am" do
  rake "generate_metrics:happiness"
end
