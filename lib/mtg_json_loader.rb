module MtgJsonLoader

  def self.load(file)
    set = JSON.parse(file.read)
    set['cards'].each do |attrs|
      attrs['card_type'] = attrs.delete('type')

      attrs.each_pair do |k,v|
          attrs[k] = v.to_s
      end

      Stamp.create!(attrs)
    end
  end

end
