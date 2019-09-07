require "json"

module Tourmaline::Model
  class InputMediaPhoto
    include JSON::Serializable

    getter type : String

    getter media : String

    getter thumb : (File | String)?

    getter caption : String?

    getter parse_mode : String?

    getter width : Int32?

    getter height : Int32?

    getter duration : Int32?

    getter supports_streaming : Bool?

    def initialize(@type : String, @media : String, @thumb : (File | String)? = nil, @caption : String? = nil, @parse_mode : String? = nil,
                   @width : Int32? = nil, @height : Int32? = nil, duration : Int32? = nil, @supports_streaming : Bool? = nil)
    end
  end
end
