class User < ApplicationRecord
  has_many :bookings
  belongs_to :school

  def cn
    "%s %s" % [self.name, self.surname]
  end

  def cn_militar
    "%s, %s" % [self.surname, self.name]
  end

  def abbr
    "%s. %s" % [self.name[0], self.surname]
  end

  def to_s
    cn
  end

  def initials
    if name.blank? || surname.blank?
      "?"
    else
      (name[0] + surname[0])
    end
  end

  def staff?
    self.staff
  end
end
