module ApplicationHelper
  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'selected' : nil

    content_tag(:li, :class => class_name) do
      link_to link_text, link_path, "data-no-turbolink" => true
    end
  end

  def rgbify(maxval, minval, val, moreisgood)
    intnsty = 1.0*(val - minval) / (maxval - minval)
    if moreisgood
      if (intnsty > 0.5)
          g = 255
          r = (2 * (1 - intnsty) * 255).round
      else
          r = 255
          g = (2 * intnsty * 255).round
      end
    else #lessisgood
      if (intnsty > 0.5)
          r = 255
          g = (2 * (1 - intnsty) * 255).round
       else
          g = 255
          r = (2 * intnsty * 255).round
      end
    end
    return "rgb(" + r.to_s + ", " + g.to_s + ", 0)"
  end

end
