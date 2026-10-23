require 'rails_helper'
require 'whenever'
require 'rake'

RSpec.describe "Happiness metrics" do
  def cron_output
    Whenever::JobList.new(file: Rails.root.join("config", "schedule.rb").to_s).
      generate_cron_output
  end

  before { KaisPterosaurEmporium::Application.load_tasks }

  it "Creates a weekly happiness snapshot" do
    # Snapshot generator is scheduled for SUnday at 2am
    expect(cron_output.split("/").first).to eq("0 2 * * 0 ")
    expect(cron_output.split("/").last).to match(/bundle exec rake generate_metrics:happiness/)

    expect { Rake::Task['generate_metrics:happiness'].invoke }.
      not_to raise_error
  end
end
