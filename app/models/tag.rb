class Tag < ApplicationRecord
    before_save :downcase_name

    has_many :taggings, dependent: :destroy
    has_many :products, through: :taggings

    validates :name, presence: true, uniqueness:{case_sensitive: false}
    private
    def downcase_name
        # self.name = self.name.downcase
        # self.name && self.name.downcase!
        # &. is the safe navigation operator. Like the dot, it will
        # execute a method. However, it will only execute if the
        # the caller is not `nil`.
        self.name&.downcase!
      end
end
