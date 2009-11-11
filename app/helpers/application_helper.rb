require 'flickr_widget/flickr_helper'
require 'twitter_widget/twitter_helper'

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include FlickrHelper
  include TwitterHelper
  
  DOCS_DIR_PATH = "#{Rails.root}/doc/"
  
  def get_full_filename(filename)
    full_filename = DOCS_DIR_PATH + filename
  end
    
  def number_to_ordinal(num)
    num = num.to_i
    if (10...20)===num
      "#{num}th"
    else
      g = %w{ th st nd rd th th th th th th }
      a = num.to_s
      c=a[-1..-1].to_i
      a + g[c]
    end
  end
  
  def friendly_date(date)
    date = DateTime.parse(date) if date.class == String
    number_to_ordinal(date.day) + date.strftime(" %b %Y")
  end
  
  def friendly_date_time(date)
    date = DateTime.parse(date) if date.class == String
    friendly_date(date) + date.strftime(" %H:%M")
  end
  
  def is_admin?
    current_user && current_user.is_admin
  end
  
  def trim_text(text)
    num_words = 80
    word_count = 0
    # parse html
    # while word_count < num_words
    #   find next tag
    #   add tag to string
    #   for each word in text
    #     inc word_count
    #     add word to string unless word_count = num_words
    #   end
    #   add ... link if word_count = num_words
    #   add end tag
    # end
  end
end
