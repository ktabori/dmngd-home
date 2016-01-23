express   = require 'express'
unirest   = require 'unirest'
router    = express.Router()

articles  = 'https://api.airtable.com/v0/appa0dfs5QLojUuh8/Articles?limit=100&view=Published'
nav       = 'https://api.airtable.com/v0/appVv3qQJXVr4clNx/Top Navigation Items?limit=100&view=Dmngd Navigation'
api       = 'http://cms.dmngd.co/api/merged/4d25745aed1ff505038777d6e75fdb39/rendered'

module.exports = (app) ->
  app.use '/', router

  router.get '/', (req, res, next) ->
    unirest.get nav
      .headers ({'Authorization': 'Bearer keyji9aGN0OHwZzZc'})
      .end (navres) ->

        unirest.get articles
          .headers ({'Authorization': 'Bearer keyji9aGN0OHwZzZc'})
          .end (articles) ->

            unirest.get api
              .end (response) ->
                data = response.body
                data.pageTitle = 'Home'
                data.navigation = navres.body.records
                data.articles = articles.body.records

                res.render 'index', data
