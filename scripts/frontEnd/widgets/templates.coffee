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
        <div class="tweet">
          <div class="user-img"><img class="tweeter-user-img" data-id="user-img" src="<%= tweets[i]["img_url"] %>"/></div>
          <div class="tweet-body">
            <h3 class="twitter-user-name" data-id="user-name"><%= tweets[i]["user_name"] %></h3>
            <p class="twitter-tweet-content" data-id="tweet-content"><%= tweets[i]["text"] %></p>
          </div>
        </div>
      <% } %>
   """, {tweets: tweets})

  @renderImage: (imgData) ->
    _.template("<img src='<%= imgData['imgSrc'] %>' data-id='<%= imgData['dataId'] %>' style='width: <%= imgData['width'] %>px'/>", {imgData: imgData})

  @renderLogo: (imgData) ->
    _.template("<img src='<%= imgData['imgSrc'] %>' data-id='<%= imgData['dataId'] %>' style='width: <%= imgData['width'] %>px'/>", {imgData: imgData})
