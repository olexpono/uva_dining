require 'constants'

class MealTime < ActiveRecord::Base
  belongs_to :dining_hall
  has_many :menu_items
  include Constants
  
  scope :todays, lambda { where(['DATE(start) = ?', Date.today]) }
  scope :breakfast, lambda { where(['TIME(start) = ?', BREAKFAST_START_TIME ])}
  scope :brunch, lambda { where(['TIME(start) = ?', BRUNCH_START_TIME ])}
  scope :dinner, lambda { where(['TIME(start) = ?', DINNER_START_TIME ])}
  scope :lunch, lambda { where(['TIME(start) = ?', LUNCH_START_TIME ])}
  scope :after_hours, lambda { where(['TIME(start) = ?', AFTER_HOURS_START_TIME ])}
  scope :soup_salad, lambda { where(['TIME(start) = ?', SOUP_SALAD_START_TIME ])}
  scope :salad, lambda { where(['TIME(start) = ?', SALAD_START_TIME ])}
  
  def self.lunch!(opts = {})
    options = {:start => LUNCH_START, :end => LUNCH_END, :meal => "Lunch"}.merge(opts)
    where(opts).todays.lunch.first || create(options)
  end
  def self.brunch!(opts = {})
    options = {:start => BRUNCH_START, :end => BRUNCH_END, :meal => "Brunch"}.merge(opts)
    where(opts).todays.brunch.first || create(options)
  end
  def self.breakfast!(opts = {})
    options = {:start => BREAKFAST_START, :end => BREAKFAST_END, :meal => "Breakfast"}.merge(opts)
    where(opts).todays.breakfast.first || create(options)
  end
  def self.dinner!(opts = {})
    options = {:start => DINNER_START, :end => DINNER_END, :meal => "Dinner"}.merge(opts)
    where(opts).todays.dinner.first || create(options)
  end
  def self.after_hours!(opts = {})
    options = {:start => AFTER_HOURS_START, :end => AFTER_HOURS_END, :meal => "After Hours"}.merge(opts)
    where(opts).todays.after_hours.first || create(options)
  end
  def self.soup_salad!(opts = {})
    options = {:start => SOUP_SALAD_START, :end => SOUP_SALAD_END, :meal => "Soup And Salad"}.merge(opts)
    where(opts).todays.soup_salad.first || create(options)
  end
  def self.salad!(opts = {})
    options = {:start => SALAD_START, :end => SALAD_END, :meal => "Salad"}.merge(opts)
    where(opts).todays.salad.first || create(options)
  end
  
end
