module FormHelper
  attr_writer :form_label_cols
  def form_label_cols
    @form_label_cols ||= 2
  end

  attr_writer :form_total_cols
  def form_total_cols
    @form_total_cols ||= 12
  end

  def form_content_cols
    form_total_cols - form_label_cols
  end

  def centered margin = 1, &proc
    content_tag(:div, class: 'row') do
      content_tag(:div, class: "col-md-offset-#{margin} col-md-#{12 - margin * 2}") do
        capture(&proc)
      end
    end
  end

  def input form, name
    content_tag(:div, class: 'form-group') do
      [
        form.label(name, class: "control-label #{label_cols_class}"),
        content_tag(:div, class: content_cols_class) do
          form.text_field(name, class: 'form-control')
        end
      ].join.html_safe
    end
  end

  def input_text form, name
    content_tag(:div, class: 'form-group') do
      [
        form.label(name, class: "control-label #{label_cols_class}"),
        content_tag(:div, class: content_cols_class) do
          form.text_area(name, class: 'form-control', rows: '12')
        end
      ].join.html_safe
    end
  end

  def input_select form, name, choices
    content_tag(:div, class: 'form-group') do
      [
        form.label(name, class: "control-label #{label_cols_class}"),
        content_tag(:div, class: content_cols_class) do
          form.select(name, choices, {}, class: 'form-control')
        end
      ].join.html_safe
    end
  end

  def buttons &proc
    content_tag(:div, class: 'form-group') do
      content_tag(:div, class: content_cols_class(with_offset: true)) do
        capture(&proc)
      end
    end
  end

  def static object, name, &proc
    content_tag(:div, class: 'form-group') do
      [
        content_tag(:label, class: "control-label #{label_cols_class}") do
          object.class.human_attribute_name name
        end,
        content_tag(:p, class: "form-control-static #{content_cols_class}") do
          proc ? capture(&proc) : object[name]
        end
      ].join.html_safe
    end
  end

  private

  def label_cols_class
    "col-md-#{form_label_cols}"
  end

  def content_cols_class options = {}
    if options[:with_offset]
      "col-md-offset-#{form_label_cols} #{content_cols_class}"
    else
      "col-md-#{form_content_cols}"
    end
  end
end
