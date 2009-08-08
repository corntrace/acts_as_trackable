class Track < ActiveRecord::Base

  include ActsAsTrackable::Track

  belongs_to :trackable, :polymorphic => true

end
