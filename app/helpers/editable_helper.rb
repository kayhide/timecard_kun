module EditableHelper
  def editable obj, attr, path, opts = {}, &proc
    disabled = opts.delete(:disabled)
    type = opts.delete(:type) || 'text'
    source = opts.delete(:source)

    attrs = {
      href: '#',
      'data-name': "#{obj.model_name.singular}[#{attr}]",
      'data-type': type,
      'data-pk': obj.id,
      'data-url': url_for(path),
      'data-title': obj.class.human_attribute_name(attr)
    }.merge(opts)
    attrs[:class] ||= []
    attrs[:class] << 'editable-click'
    attrs[:class] << 'editable-disabled' if disabled
    if source
      attrs[:'data-source'] = source.map { |v, t| { value: v, text: t } }.to_json
    end
    content_tag :a, attrs do
      capture &proc
    end
  end
end
