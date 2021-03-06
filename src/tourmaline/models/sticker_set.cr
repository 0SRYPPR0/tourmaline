require "json"

module Tourmaline::Model
  class StickerSet
    include JSON::Serializable

    getter name : String

    getter title : String

    getter is_animated : Bool

    getter contains_masks : Bool

    getter stickers : Array(Sticker)
  end
end
