require "json"
require "./message_entity"

module Tourmaline::Model
  # # This object represents a Telegram user or bot.
  class Message
    include JSON::Serializable

    getter message_id : Int64

    getter from : User?

    @[JSON::Field(converter: Time::EpochMillisConverter)]
    getter date : Time

    getter chat : Chat

    getter forward_from : User?

    getter forward_from_chat : Chat?

    getter forward_from_message_id : Int64?

    getter forward_signature : String?

    @[JSON::Field(converter: Time::EpochMillisConverter)]
    getter forward_date : Time?

    @[JSON::Field(converter: Time::EpochMillisConverter)]
    getter edit_date : Time?

    @[JSON::Field(key: "reply_to_message")]
    getter reply_message : Message?

    getter media_group_id : String?

    getter author_signature : String?

    getter text : String?

    getter entities : Array(MessageEntity) = [] of Tourmaline::Model::MessageEntity

    getter caption_entities : Array(MessageEntity) = [] of Tourmaline::Model::MessageEntity

    getter audio : Audio?

    getter document : Document?

    getter game : Game?

    getter photo : Array(PhotoSize) = [] of Tourmaline::Model::PhotoSize

    getter sticker : Sticker?

    getter video : Video?

    getter voice : Voice?

    getter video_note : VideoNote?

    getter caption : String?

    getter contact : Contact?

    getter location : Location?

    getter venue : Venue?

    getter new_chat_members : Array(User) = [] of Tourmaline::Model::User

    getter left_chat_member : User?

    getter new_chat_title : String?

    getter new_chat_photo : Array(PhotoSize) = [] of Tourmaline::Model::PhotoSize

    getter delete_chat_photo : Bool?

    getter group_chat_created : Bool?

    getter supergroup_chat_created : Bool?

    getter channel_chat_created : Bool?

    getter migrate_to_chat_id : Int64?

    getter migrate_from_chat_id : Int64?

    getter invoice : Invoice?

    getter successful_payment : SuccessfulPayment?

    def link
      if chat.username
        "https://t.me/#{chat.username}/#{message_id}"
      else
        "https://t.me/c/#{chat.id}/#{message_id}"
      end
    end

    def text_entities
      return {} of MessageEntity => String unless text
      entities.map do |item|
        {type: item.type, text: text[item.offset..item.size]}
      end
    end

    # Delete the message. See `Tourmaline::Bot#delete_message`.
    def delete
      BotContainer.bot.delete_message(chat, message_id)
    end

    # Edits the message's caption. See `Tourmaline::Bot#edit_message_caption`
    def edit_caption(caption, **kwargs)
      BotContainer.bot.edit_message_caption(chat, caption, **kwargs, message_id: message_id)
    end

    # Set the reply markup for the message. See `Tourmaline::Bot#edit_message_reply_markup`.
    def edit_reply_markup(reply_markup)
      BotContainer.bot.edit_message_reply_markup(chat, message_id: message_id, reply_markup: reply_markup)
    end

    # Edits the text of a message. See `Tourmaline::Bot#edit_message_text`.
    def edit_text(text, **kwargs)
      BotContainer.bot.edit_message_text(chat, text, **kwargs, message_id: message_id)
    end

    # Forward the message to another chat. See `Tourmaline::Bot#forward_message`.
    def forward(to_chat, **kwargs)
      BotContainer.bot.forward_message(to_chat, chat, message_id, **kwargs)
    end

    # Pin the message. See `Tourmaline::Bot#pin_message`.
    def pin(**kwargs)
      BotContainer.bot.pin_message(chat, message_id, **kwargs)
    end

    # Reply to a message. See `Tourmaline::Bot#send_message`.
    def reply(message, **kwargs)
      BotContainer.bot.send_message(chat, message, **kwargs, reply_to_message: message_id)
    end

    # Respond to a message. See `Tourmaline::Bot#send_message`.
    def respond(message, **kwargs)
      BotContainer.bot.send_message(chat, message, **kwargs, reply_to_message: nil)
    end

    {% for content_type in %w[audio animation contact document location photo media_group venu video video_note voice] %}
      def reply_with_{{content_type.id}}(*args, **kwargs)
        BotContainer.bot.send_{{content_type.id}}(chat, *args, **kwargs, reply_to_message: message_id)
      end

      def respond_with_{{content_type.id}}(*args, **kwargs)
        BotContainer.bot.send_{{content_type.id}}(chat, *args, **kwargs, reply_to_message: nil)
      end
    {% end %}

    def edit_live_location(latitude, longitude, **kwargs)
      BotContainer.bot.edit_message_live_location(chat, latitude, longitude, **kwargs, message_id: message_id)
    end

    def stop_live_location(**kwargs)
      BotContainer.bot.stop_message_live_location(chat, message_id, **kwargs)
    end
  end
end
