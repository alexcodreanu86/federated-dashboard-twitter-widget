#federated-dashboard-twitter-widget

To install this package you can either run `bower install twitter-widget` or include it in your bower.json dependencies section.

For a preview of how it works you can copy the contents of the `twitter-widget/example` directory into the root of your project. After that you can run the command `npm install` to have all the dependencies installed.
Next you will have to set your twitter api keys into your environment by executing the following commands replacing the "xxxxx" parts with your api keys from [twitter](https://dev.twitter.com):
```
export TWITTER_API_KEY=xxxxxxxxxxxxxxxxxxxxxxxxx
export TWITTER_API_SECRET=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
export TWITTER_ACCESS_TOKEN=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
export TWITTER_ACCESS_TOKEN_SECRET=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

```
If your bower components are not installed in the bower_components directory then you will have to update the routes in the views/index.ejs and in the server.js to point to the location where your bower components are saved.
Now you should be ready to try the server by executing `node server.js` in the same shell tab where you have set the environment variables.

Twitter image logo html can be generated with the command:
`Twitter.Display.generateLogo({dataId: "twitter-logo", width: 100})`. This will generate the following html:

```html
<img src='https://raw.githubusercontent.com/bwvoss/federated-dashboard-twitter-widget/master/lib/icon_25838/icon_25838.png' data-id='twitter-logo' style='width: 100px'/>
```


Credits to:

Icon:

Twitter designed by Maria Maldonado from the Noun Project
