require 'csv'

# rails import:tourists
namespace :import do
  desc 'Import lists from csv'

  task tourists: :environment do
    path = File.join Rails.root, 'db/csv/import.csv'
    puts "path: #{path}"
    list = []
    CSV.foreach(path, headers: true) do |row|
      list << {
        place_name: row['名称'],
        latitude: row['北緯'],
        longitude: row['東経'],
        address: row['所在地'],
        notice: row['備考']
      }
    end
    puts 'start to create prefectures data'
    begin
      Tourist.create!(list)
      puts 'completed!!'
    rescue ActiveModel::UnknownAttributeError => e
      puts 'raised error : unKnown attribute '
    end
  end
end
