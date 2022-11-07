module ShaleCustom
  class Xml < Shale::Mapping::Xml
    def map_element(
      element,
      to: nil,
      using: nil,
      namespace: :undefined,
      prefix: :undefined,
      cdata: false,
      render_nil: true
    )
      super(
        element,
        to: to,
        using: using,
        namespace: namespace,
        prefix: prefix,
        cdata: cdata,
        render_nil: render_nil
      )
    end
  end
end
