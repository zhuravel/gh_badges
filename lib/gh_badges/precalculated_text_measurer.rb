module GhBadges
  class PrecalculatedTextMeasurer
    def self.default
      @default ||= begin
        o = GhBadges.default_widths

        new(o["mean-character-length"],
            o["character-lengths"],
            o["kerning-pairs"])
      end
    end

    def initialize(default_character_width, char_to_width, pair_to_kern)
      @default_character_width = default_character_width
      @char_to_width = char_to_width
      @pair_to_kern = pair_to_kern
    end

    def text_width(text)
      width = 0
      text.each_char.with_index do |c, index|
        width += @char_to_width.fetch(c, @default_character_width)
        width -= @pair_to_kern.fetch(text[index..(index + 2)], 0)
      end

      width
    end
  end
end
