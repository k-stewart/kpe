namespace :generate_metrics do
  desc "Create a snapshot of total pterosaur happiness, and the most common reasons for unhappiness"
  task happiness: :environment do
    HappinessChecker.calculate
  end
end
