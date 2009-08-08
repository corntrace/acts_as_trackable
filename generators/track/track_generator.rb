class TrackGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.directory 'app/models'
      m.file 'track.rb', 'app/models/track.rb'
      m.migration_template "create_tracks.rb", "db/migrate"
    end
  end
  # ick what a hack.
  def file_name
     "create_tracks"
  end
end
