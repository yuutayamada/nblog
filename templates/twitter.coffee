#  You can get the information from https://twitter.com/settings/widgets/
#  see : https://dev.twitter.com/ja/docs/embedded-timelines
if userConfig.twitter.account and userConfig.twitter.widget_id
  TwitterView = Backbone.View.extend({
    tagName: 'div'
    initialize: -> this.renderTwitter()
    renderTwitter: ->
      account = userConfig.twitter.account
      id      = userConfig.twitter.widget_id
      twitter = this.createTwitterTemplate(account, id)
      $("#sidebar").append("<div id='twitterback'>"+twitter+"</div>")
      ((d,s,id) ->
        js
        fjs = d.getElementsByTagName(s)[0]
        p = if /^http:/.test(d.location) then 'http' else 'https'
        if !d.getElementById(id)
          js = d.createElement(s)
          js.id = id
          js.src = p + "://platform.twitter.com/widgets.js"
          fjs.parentNode.insertBefore(js, fjs)
      )(document, "script", "twitter-wjs")
    createTwitterTemplate: (account, id) ->
      twitter = '<a class="twitter-timeline"  href="https://twitter.com/'
      user = account + '" data-widget-id="' + id + '" '
      theme = '''
        data-theme="dark" data-chrome="nofooter transparent noscrollbar"
        data-link-color="#00ffff" data-aria-polite="assertive"
      '''
      tweetsby = '>Tweets by @' + account + '</a>'
      return twitter + user + theme + tweetsby
    }
  )
  view = new TwitterView({el: '#sidebar'})
