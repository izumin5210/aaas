class ApplicationRepresenter
  include Garage::Representer

  attr_reader :model

  def initialize(model)
    @model = model
  end
end
