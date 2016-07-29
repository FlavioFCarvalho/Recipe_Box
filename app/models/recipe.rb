class Recipe < ActiveRecord::Base
    belongs_to :user
    paginates_per 3 
    has_many :ingredients, dependent: :destroy
    has_many :directions, dependent: :destroy
    has_many :recipe_categories, dependent: :destroy
    has_many :comments, dependent: :destroy

    accepts_nested_attributes_for :recipe_categories,
                                  reject_if: proc{|attributes| attributes['category_id'].blank?},
                                  allow_destroy: true

    accepts_nested_attributes_for :ingredients,
                                  reject_if: proc{|attributes| attributes['name'].blank?},
                                  allow_destroy: true

    accepts_nested_attributes_for :directions,
                                  reject_if: proc{|attributes| attributes['step'].blank?},
                                  allow_destroy: true                                 
       
  validates :title, :description,presence: true   
	has_attached_file :image, styles: { :medium => "400x400#" }
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
