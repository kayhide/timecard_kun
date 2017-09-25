class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  def form_group field, options = {}, &block
    options[:class] = options[:class].to_s.tap do |opt|
      opt << ' ' if opt.present?
      opt << 'form-group'
      opt << ' has-error' if @object.errors.has_key?(field)
    end
    @template.content_tag :div, options, &block
  end

  def label *args, &block
    args << {} unless Hash === args.last
    options = args.last
    options[:class] = options[:class].to_s.tap do |opt|
      opt << ' ' if opt.present?
      opt << 'control-label'
    end
    super *args, &block
  end

  def error_messages field
    if messages = @object.errors[field]
      @template.content_tag :p, messages.join(@template.tag(:br)).html_safe, :class => 'help-block'
    end
  end
end
