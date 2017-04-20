class Background < ApplicationRecord
  belongs_to :consultation

  validates_presence_of :background_type, :description
end
