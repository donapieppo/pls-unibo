class User < ApplicationRecord
  has_many :bookings
  belongs_to :school, optional: true

  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP, message: "Formato della mail non corretto"}

  def cn
    "%s %s" % [name, surname]
  end

  def cn_militar
    "%s, %s" % [surname, name]
  end

  def abbr
    "%s. %s" % [name[0], surname]
  end

  def to_s
    cn
  end

  def initials
    if name.blank? || surname.blank?
      "?"
    else
      (name.strip[0] + surname.strip[0])
    end
  end

  def staff?
    staff
  end

  def student_secondary?
    role && role == "student_secondary"
  end

  def student_university?
    role && role == "student_university"
  end

  def teacher?
    role && role == "teacher"
  end

  # FIXME TODO
  def confirmed_teacher?
    role && role == "teacher"
  end

  def unibo_account?
    email.match?(/\A\w+\.?\w+@unibo.it\z/)
  end

  def google_account?
    email.match?(/\A.+@gmail.com\z/)
  end

  def master_of_universe?
    CESIA_UPN.include?(email)
  end

  def voyeur?
    staff? || BOOKING_WATCHERS.include?(email)
  end
end
