class Profile < ActiveRecord::Base
  belongs_to :user

  validate :first_and_last_names, :no_male_sue
  validates :gender, inclusion: %w(male female)

  def first_and_last_names
    if first_name.nil? and last_name.nil?
      errors.add :last_name, "both first and last names cannot be null"
    end
  end

  def no_male_sue
    if gender == "male" and first_name == "Sue"
      errors.add gender, "male cannot be Sue"
    end
  end

  def self.get_all_profiles min_year, max_year
    Profile.all.where("birth_year BETWEEN ? AND ?", min_year, max_year).order(birth_year: :asc)
  end
end
