module Tourmaline::Model
  class MessageEntity
    include JSON::Serializable

    MENTION_TYPES = %w[
      mention text_mention hashtag cashtag bot_command url email phone_number
      bold italic code pre text_link
    ]

    getter type : String

    getter offset : Int64

    getter length : Int64

    getter url : String?

    getter user : User?

    {% for mention_type in MENTION_TYPES %}
      def {{mention_type.id}}?
        @type == {{mention_type}}
      end
    {% end %}
  end
end
