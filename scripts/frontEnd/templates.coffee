namespace('Twitter')

class Twitter.Templates
  @renderForm: ->
    _.template("""
                  <input name="twitter-search" type="text"><br>
                  <button id="twitter" data-id="twitter-button">Search twitter</button><br>
                  <div data-id="twitter-output"></div>
               """)

  @renderTweets: (tweets) ->
    _.template("""
                <% for(var i = 0; i< tweets.length; i++) { %>
                <p><%= i + 1 %> <%= tweets[i]["text"] %></p>
                <% } %>
              """, {tweets: tweets})
