require 'csv'

namespace :import do
  task data: :environment do
    CSV.foreach('db/data/olympic_data_2016.csv', headers: true) do |row|
      if row['Medal'] == 'NA'
        medal = nil
      else
        medal = row['Medal'].downcase
      end

      if row['Height'] == 'NA'
        height = nil
      else
        height = row['Height'].to_i
      end

      if row['Weight'] == 'NA'
        weight = nil
      else
        weight = row['Weight'].to_i
      end

      team = Team.find_or_create_by!(country: row['Team'].split('-').first)
      sport = Sport.find_or_create_by!(name: row['Sport'])
      event = Event.find_or_create_by!(name: row['Event'], sport: sport)
      olympian = Olympian.find_or_create_by!(
        name: row['Name'],
        sex: row['Sex'],
        age: row['Age'],
        height: height,
        weight: weight,
        team: team,
        sport: sport
      )
      OlympianEvent.create!(
        olympian: olympian,
        event: event,
        medal: medal
      )
    end
  end
end
