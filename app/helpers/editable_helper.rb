module EditableHelper
  def editable obj, attr, path, opts = {}, &proc
    disabled = opts.delete(:disabled)

    attrs = {
      href: '#',
      'data-name': "#{obj.model_name.singular}[#{attr}]",
      'data-type': 'text',
      'data-pk': obj.id,
      'data-url': url_for(path),
      'data-title': obj.class.human_attribute_name(attr)
    }.merge(opts)
    attrs[:class] ||= []
    attrs[:class] << 'editable-click'
    attrs[:class] << 'editable-disabled' if disabled
    content_tag :a, attrs do
      capture &proc
    end
  end
end
