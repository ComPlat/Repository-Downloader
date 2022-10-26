require "rails_helper"

describe PresenterHelper do
  describe "present" do
    context "initializes a presenter class for an object"

    before do
      stub_const("DummyClass", Class.new)
      DummyClass.extend(PresenterHelper)
    end

    it do
      stub_const("Pen", Class.new)
      stub_const("PenPresenter", Struct.new(:pen))

      pen = Pen.new
      presenter = DummyClass.present(pen)

      expect(presenter).to be_a(PenPresenter)
    end
  end
end
