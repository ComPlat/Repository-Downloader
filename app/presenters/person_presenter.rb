require "shale"

class PersonPresenter < SimpleDelegator
  attr_reader :person

  def initialize(person)
    @person = person
    super(person)
  end

  def full_name
    "#{@person.first_name} #{@person.last_name}"
  end

  def to_json
    @person.to_json
  end

  def to_xml
    @person.to_xml
  end

  def to_csv
    @person.to_csv
  end
end
