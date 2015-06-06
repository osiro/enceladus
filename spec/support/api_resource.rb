require 'ostruct'
class ApiResource < OpenStruct
  def to_h
    hashfied_resource = self.marshal_dump

    hashfied_resource.keys.each do |attr|
      if self.public_send(attr).kind_of?(ApiResource)
        hashfied_resource[attr] = hashfied_resource[attr].to_h
      end
    end

    hashfied_resource
  end

  def to_json(*args)
    jsonfied_resource = to_h

    jsonfied_resource.keys.each do |attr|
      if self.public_send(attr).kind_of?(ApiResource)
        jsonfied_resource[attr] = jsonfied_resource[attr].to_h
      end
    end

    jsonfied_resource.to_json(args)
  end
end