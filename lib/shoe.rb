class Shoe <ActiveRecord::Base
  has_and_belongs_to_many(:stores)
  validates(:brand, :presence => true)
  before_save(:capitalize_brand)

  private
    define_method(:capitalize_brand) do
      self.brand = (brand().capitalize())
    end
end
