class MigrateReviewSite < Mongoid::Migration
  def self.up
    Rating.all.each do |rating|
    # value was replaced with Cat1Value
    rating.set :Cat1Value, rating[:value] # copy the data from the old field to the new one
    rating.remove_attribute :value # remove the old field from the document
    rating.save!
  end

  def self.down
  end
end
