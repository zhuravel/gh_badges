require "gh_badges/version"
require "gh_badges/badge_template"
require "gh_badges/default_widths"
require "gh_badges/precalculated_text_measurer"
require "erb"

module GhBadges
  # Use the same color scheme as describe in:
  # https://github.com/badges/shields/blob/master/lib/colorscheme.json
  COLOR_SCHEME = {
    "brightgreen" => "#4c1",
    "green" => "#97ca00",
    "yellow" => "#dfb317",
    "yellowgreen" => "#a4a61d",
    "orange" => "#fe7d37",
    "red" => "#e05d44",
    "blue" => "#007ec6",
    "grey" => "#555",
    "gray" => "#555",
    "lightgrey" => "#9f9f9f",
    "lightgray" => "#9f9f9f"
  }

  def self.badge(left_text, right_text, left_link: nil,
                 right_link: nil, whole_link: nil, logo: nil,
                 left_color: "#555", right_color: "#007ec6", measurer: nil)

    measurer ||= PrecalculatedTextMeasurer.default

    if (left_link || right_link) && whole_link
      raise ArgumentError, "whole_link may not bet set with left_link or right_link"
    end

    left_text_width = measurer.text_width(left_text) / 10.0
    right_text_width = measurer.text_width(right_text) / 10.0
    left_color = COLOR_SCHEME.fetch(left_color, left_color)
    right_color = COLOR_SCHEME.fetch(right_color, right_color)

    ERB.new(badge_template).result(binding)
  end
end
