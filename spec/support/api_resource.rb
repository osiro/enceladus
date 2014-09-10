class ApiResource < OpenStruct
  def to_h
    hashfied_resource = super

    hashfied_resource.keys.each do |attr|
      if self.send(attr).kind_of?(ApiResource)
        hashfied_resource[attr] = hashfied_resource[attr].to_h
      end
    end

    hashfied_resource
  end

  def to_json(*args)
    jsonfied_resource = to_h

    jsonfied_resource.keys.each do |attr|
      if self.send(attr).kind_of?(ApiResource)
        jsonfied_resource[attr] = jsonfied_resource[attr].to_h
      end
    end

    jsonfied_resource.to_json(args)
  end
end