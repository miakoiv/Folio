# CompoundDatetime models a PORO that stores a datetime object
# that can be broken down to date and time components, and assigned
# a new value from an attribute hash, making it compatible with
# nested attributes coming from a form.
#
# See <http://blog.iany.me/2013/01/rails-compound-input/>
#
class CompoundDatetime
  attr_accessor :datetime

  def initialize(datetime)
    @datetime = datetime
  end

  def assign_attributes(hash)
    if hash[:date].present?
      @datetime = Time.zone.parse(
        [hash[:date].presence, hash[:time].presence || ''].join(' ')
      )
    end
    self
  end

  def date
    @datetime.strftime '%Y-%m-%d' if @datetime
  end

  def time
    @datetime.strftime '%H:%M' if @datetime
  end

  def persisted?; false; end
end
