module MtgJsonLoader

  # Pass either hash or filename.
  def self.load_set(arg)
    if arg.is_a?(Hash)
      arg['cards'].each do |attrs|
        attrs['card_type'] = attrs.delete('type')

        attrs.each_pair do |k,v|
          attrs[k] = v.to_s
        end

        Stamp.create!(attrs)
      end
    else
      file = File.new(arg)
      json = JSON.parse(file.read)
      ::MtgJsonLoader.load_set(json)
    end
  end

end
