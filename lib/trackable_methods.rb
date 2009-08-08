require 'activerecord'

# ActsAsTrackable
module Corntrace
  module Acts #:nodoc:
    module Trackable #:nodoc:

      def self.included(base)
        base.extend ClassMethods  
      end

      module ClassMethods
        def acts_as_trackable
          has_many :tracks, :as => :trackable, :dependent => :destroy
          include Corntrace::Acts::Trackable::InstanceMethods
          extend Corntrace::Acts::Trackable::SingletonMethods
        end
      end
      
      # This module contains class methods
      module SingletonMethods
        # Helper method to lookup for comments for a given object.
        # This method is equivalent to obj.comments.
        def find_tracks_for(obj)
          trackable = ActiveRecord::Base.send(:class_name_of_active_record_descendant, self).to_s
         
          Track.find(:all,
            :conditions => ["trackable_id = ? and trackable_type = ?", obj.id, trackable],
            :order => "created_at DESC"
          )
        end
        
        # Helper class method to lookup comments for
        # the mixin commentable type written by a given user.  
        # This method is NOT equivalent to Comment.find_comments_for_user
        def find_comments_by_operator(name) 
          trackable = ActiveRecord::Base.send(:class_name_of_active_record_descendant, self).to_s
          
          Track.find(:all,
            :conditions => ["operator_name = ? and trackable_type = ?", name, trackable],
            :order => "created_at DESC"
          )
        end
      end
      
      # This module contains instance methods
      module InstanceMethods
        # Helper method to sort comments by date
        def tracks_ordered_by_submitted
          Track.find(:all,
            :conditions => ["trackable_id = ? and trackable_type = ?", id, self.class.name],
            :order => "created_at DESC"
          )
        end
        
        # Helper method that defaults the submitted time.
        def add_track(track)
          tracks << track
        end
      end
      
    end
  end
end

ActiveRecord::Base.send(:include, Corntrace::Acts::Trackable)
