express   = require 'express'
unirest   = require 'unirest'
router    = express.Router()

articles  = 'https://api.fieldbook.com/v1/567b129370964203001b2a3f/articles'
nav       = 'https://api.fieldbook.com/v1/567b129370964203001b2a3f/main_navigation'
api       = 'http://cms.dmngd.co/api/merged/4d25745aed1ff505038777d6e75fdb39/rendered'

module.exports = (app) ->
  app.use '/', router

  router.get '/', (req, res, next) ->
    unirest.get nav
      .end (navres) ->

        unirest.get articles
          .end (articles) ->

            unirest.get api
              .end (response) ->
                data = response.body
                data.pageTitle = 'Home'
                data.navigation = navres.body
                data.articles = articles.body
                res.render 'index', data
