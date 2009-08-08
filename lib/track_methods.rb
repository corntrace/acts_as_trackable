module ActsAsTrackable
  # including this module into your Track model will give you finders and named scopes
  # useful for working with Tracks.
  # The named scopes are:
  #   in_order: Returns tracks in the order they were created (created_at ASC).
  #   recent: Returns tracks by how recently they were created (created_at DESC).
  #   limit(N): Return no more than N tracks.
  module Track
    
    def self.included(track_model)
      track_model.extend Finders
      track_model.named_scope :in_order, {:order => 'created_at ASC'}
      track_model.named_scope :recent, {:order => "created_at DESC"}
      track_model.named_scope :limit, lambda {|limit| {:limit => limit}}
    end
    
    module Finders
      # Helper class method to lookup all tracks assigned
      # to all trackable types for a given user.
      def find_tracks_by_operator(name)
        find(:all,
          :conditions => ["operator_name = ?", name],
          :order => "created_at DESC"
        )
      end

      # Helper class method to look up all tracks for 
      # trackable class name and trackable id.
      def find_tracks_for_trackable(trackable_str, trackable_id)
        find(:all,
          :conditions => ["trackable_type = ? and trackable_id = ?", trackable_str, trackable_id],
          :order => "created_at DESC"
        )
      end

      # Helper class method to look up a trackable object
      # given the trackable class name and id 
      def find_trackable(trackable_str, trackable_id)
        trackable_str.constantize.find(trackable_id)
      end
    end
  end
end
