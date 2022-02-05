module Colorable
  def background_color_is_too_dark?
    color_is_too_dark?(self.background_color)
  end

  def color_is_too_dark?(hex_color)
    return false if hex_color.length != 7

    r, g, b = hex_to_rgb(hex_color)

    # Per ITU-R BT.709
    luma = 0.2126 * r + 0.7152 * g + 0.0722 * b

    luma < 80 ? true : false
  end

  def hex_to_rgb(rgb)
    rgb.delete('#')
       .scan(/\w{2}/)
       .map(&:hex)
  end
end
