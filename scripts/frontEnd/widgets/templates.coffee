namespace('Twitter.Widgets')

class Twitter.Widgets.Templates
  @renderForm: ->
    _.template("""
                <div class="widget" data-id="twitter-widget-wrapper">
                  <div class="widget-header">
                    <h2 class="widget-title">Twitter</h2>
                    <span class='widget-close' data-id='twitter-close'>×</span>
                    <div class="widget-form" data-id="twitter-form">
                      <input name="twitter-search" type="text" autofocus="true">
                      <button id="twitter" data-id="twitter-button">Search twitter</button><br>
                    </div>
                  </div>
                  <div class="widget-body" data-id="twitter-output"></div>
                </div>
               """)

  @renderTweets: (tweets) ->
    _.template("""
                <% for(var i = 0; i< tweets.length; i++) { %>
                <p><%= i + 1 %> <%= tweets[i]["text"] %></p>
                <% } %>
              """, {tweets: tweets})

  @renderImage: (imgData) ->
    _.template("<img src='<%= imgData['imgSrc'] %>' data-id='<%= imgData['dataId'] %>' style='width: <%= imgData['width'] %>px'/>", {imgData: imgData})

  @renderLogo: (imgData) ->
    _.template("<img src='<%= imgData['imgSrc'] %>' data-id='<%= imgData['dataId'] %>' style='width: <%= imgData['width'] %>px'/>", {imgData: imgData})
