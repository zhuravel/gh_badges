module GhBadges
  BADGE_TEMPLATE = <<-ERB.gsub(/>\s*/, ">").gsub(/\s*</, "<")
    <% logo_width = logo ? 14 : 0 %>
    <% logo_padding = logo && left_text ? 3 : 0 %>
    <% left_width = left_text_width + 10 + logo_width + logo_padding %>
    <% right_width = right_text_width + 10 %>
    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="<%= left_width + right_width %>" height="20">
      <linearGradient id="smooth" x2="0" y2="100%">
        <stop offset="0" stop-color="#bbb" stop-opacity=".1"/>
        <stop offset="1" stop-opacity=".1"/>
      </linearGradient>

      <clipPath id="round">
        <rect width="<%= left_width + right_width %>" height="20" rx="3" fill="#fff"/>
      </clipPath>

      <g clip-path="url(#round)">
        <rect width="<%= left_width %>" height="20" fill="<%= left_color %>"/>
        <rect x="<%= left_width %>" width="<%= right_width %>" height="20" fill="<%= right_color %>"/>
        <rect width="<%= left_width + right_width %>" height="20" fill="url(#smooth)"/>
      </g>

      <g fill="#fff" text-anchor="middle" font-family="DejaVu Sans,Verdana,Geneva,sans-serif" font-size="110">
        <% if logo %>
          <image x="5" y="3" width="<%= logo_width %>" height="14" xlink:href="<%= logo %>"/>
        <% end %>
        <text x="<%= (((left_width+logo_width+logo_padding)/2)+1)*10 %>" y="150" fill="#010101" fill-opacity=".3" transform="scale(0.1)" textLength="<%= (left_width-(10+logo_width+logo_padding))*10 %>" lengthAdjust="spacing"><%= left_text %></text>
        <text x="<%= (((left_width+logo_width+logo_padding)/2)+1)*10 %>" y="140" transform="scale(0.1)" textLength="<%= (left_width-(10+logo_width+logo_padding))*10 %>" lengthAdjust="spacing"><%= left_text %></text>
        <text x="<%= (left_width+right_width/2-1)*10 %>" y="150" fill="#010101" fill-opacity=".3" transform="scale(0.1)" textLength="<%= (right_width-10)*10 %>" lengthAdjust="spacing"><%= right_text %></text>
        <text x="<%= (left_width+right_width/2-1)*10 %>" y="140" transform="scale(0.1)" textLength="<%= (right_width-10)*10 %>" lengthAdjust="spacing"><%= right_text %></text>

      <% if left_link || whole_link %>
        <a xlink:href="<%= left_link || wholelink %>">
          <rect width="<%= left_width %>" height="20" fill="rgba(0,0,0,0)"/>
        </a>
      <% end %>
      <% if right_link || whole_link %>
        <a xlink:href="<%= right_link || whole_link %>">
          <rect x="<%= left_width %>" width="<%= right_width %>" height="20" fill="rgba(0,0,0,0)"/>
        </a>
      <% end %>
      </g>
    </svg>
  ERB

  def self.badge_template
    BADGE_TEMPLATE
  end
end
