require 'grackle'

class Tweet < ActiveRecord::Base

  MY_APPLICATION_NAME = "Tweets Test Demo"
  
  """Connect to the Twitter API and pull down the latest tweets"""
  def self.get_latest
    tweets = client.statuses.user_timeline? :screen_name => Tweets_Test_Demo # hit the API
    tweets.each do |t|
      created = DateTime.parse(t.created_at)
      # create the tweet if it doesn't already exist
      unless Tweet.exists?(["created=?", created])
        Tweet.create({:content => t.text, :created => created })
       end
    end
  end
  
  private
  def self.client
    Grackle::Client.new(:auth=>{
      :type=>:oauth,
      :consumer_key=>'4vPGql9omClwrNdj5bCsH3jrb',
      :consumer_secret=>'q5JXgwJIR22tmAJTBq6yQCmh8eDHY7I4zeLvlP0I9yzzsBLJJH',
      :token=>"366751897-fFDrkEhgghKFXDS0ioIvGj7Otqz9jGzFlGY0b5np",
      :token_secret=>"DSQR6rqhb5kVdZeCVkcOXCPrUGfjfaOAnWJRWrPR4KIQ2"
    })

  end
end