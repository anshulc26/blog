class Contact < ActiveRecord::Base

	validates_presence_of :name
	validates_length_of :name, :in => 1..30, :if => Proc.new { |obj| obj.name.present? }
	# validates_format_of :name, :with => /\A[a-zA-Z\ \'\.]\Z/i, :if => Proc.new { |obj| obj.name.present? }

	validates_presence_of :email
	validates_length_of :email, :in => 6..200, :if => Proc.new { |obj| obj.email.present? }
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :if => Proc.new { |obj| obj.email.present? }

	validates :number, numericality: { only_integer: true }, :if => Proc.new { |obj| obj.number.present? }
	validates :number, length: { minimum: 10 }, :if => Proc.new { |obj| obj.number.present? }

	validates_presence_of :message
	validates_length_of :message, :in => 2..500, :if => Proc.new { |obj| obj.message.present? }
end
