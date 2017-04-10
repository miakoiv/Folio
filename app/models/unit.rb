class Unit < ApplicationRecord

  include Translatable
  resourcify

  has_many :users
  has_many :customers
  has_many :events
  has_many :notes, through: :customers
  has_many :posts
  has_many :activities

  has_many :templates
  has_one :header_template, -> { merge(Template.header) }, class_name: 'Template'
  has_one :footer_template, -> { merge(Template.footer) }, class_name: 'Template'
  has_one :review_template, -> { merge(Template.review) }, class_name: 'Template'


  scope :accessible_by, -> (user) { joins(roles: :users).where(users: {id: user}) }


  def self.to_collection_title
    model_name.human(count: 2).capitalize
  end

  def to_s
    name
  end
end
