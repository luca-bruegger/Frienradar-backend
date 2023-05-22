class GeohashGenerator
  class << self
    def generate(geohash_length: 6)
      geohash = ''
      geohash_length.times do
        geohash += self.geohash_charset.sample
      end
      geohash
    end

    private

    def geohash_charset
      %w[0 1 2 3 4 5 6 7 8 9 b c d e f g h j k m n p q r s t u v w x y z].freeze
    end
  end
end
