class User < ApplicationRecord
  has_many :bookings
  belongs_to :school, optional: true

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Formato della mail non corretto" }

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
      (self.name[0] + self.surname[0])
    end
  end

  def staff?
    self.staff
  end

  def student?
    self.role && self.role == 'student'
  end

  def teacher?
    self.role && self.role == 'teacher'
  end

  # FIXME TODO
  def confirmed_teacher?
    self.role && self.role == 'teacher'
  end

  def unibo_account?
    self.email =~ /\A\w+\.?\w+@unibo.it\z/
  end

  def google_account?
    self.email =~ /\A.+@gmail.com\z/
  end

  def master_of_universe?
    cesia_upn.include?(self.email)
  end

  def voyeur?
    VOYEURS.include?(self.email)
  end
end
