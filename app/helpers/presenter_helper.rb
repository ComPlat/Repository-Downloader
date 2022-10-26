module PresenterHelper
  def present(model)
    presenter_class = model.class.name + "Presenter"
    presenter_class.constantize.new(model)
  end
end
