require "json"

module Tourmaline::Model
  class PhotoSize
    include JSON::Serializable

    getter file_id : String

    getter width : Int32

    getter height : Int32

    getter file_size : Int64
  end
end
