require 'constants'

class MealTime < ActiveRecord::Base
  belongs_to :dining_hall
  has_many :menu_items
  include Constants
  
  scope :todays, lambda { where(['start > ?', Date.today]) }
  scope :breakfast, lambda { where(['start = ?', BREAKFAST_START ])}
  scope :brunch, lambda { where(['start = ?', BRUNCH_START ])}
  scope :dinner, lambda { where(['start = ?', DINNER_START ])}
  scope :lunch, lambda { where(['start = ?', LUNCH_START ])}
  scope :after_hours, lambda { where(['start = ?', AFTER_HOURS_START ])}
  scope :soup_salad, lambda { where(['start = ?', SOUP_SALAD_START ])}
  scope :salad, lambda { where(['start = ?', SALAD_START ])}
  
  def self.lunch!(opts = {})
    options = {:start => LUNCH_START, :end => LUNCH_END, :meal => "Lunch"}.merge(opts)
    where(opts).lunch.first || create(options)
  end
  def self.brunch!(opts = {})
    options = {:start => BRUNCH_START, :end => BRUNCH_END, :meal => "Brunch"}.merge(opts)
    where(opts).brunch.first || create(options)
  end
  def self.breakfast!(opts = {})
    options = {:start => BREAKFAST_START, :end => BREAKFAST_END, :meal => "Breakfast"}.merge(opts)
    where(opts).breakfast.first || create(options)
  end
  def self.dinner!(opts = {})
    options = {:start => DINNER_START, :end => DINNER_END, :meal => "Dinner"}.merge(opts)
    where(opts).dinner.first || create(options)
  end
  def self.after_hours!(opts = {})
    options = {:start => AFTER_HOURS_START, :end => AFTER_HOURS_END, :meal => "After Hours"}.merge(opts)
    where(opts).after_hours.first || create(options)
  end
  def self.soup_salad!(opts = {})
    options = {:start => SOUP_SALAD_START, :end => SOUP_SALAD_END, :meal => "Soup And Salad"}.merge(opts)
    where(opts).soup_salad.first || create(options)
  end
  def self.salad!(opts = {})
    options = {:start => SALAD_START, :end => SALAD_END, :meal => "Salad"}.merge(opts)
    where(opts).salad.first || create(options)
  end
  
end
