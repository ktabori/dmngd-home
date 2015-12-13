express   = require 'express'
unirest   = require 'unirest'
router    = express.Router()

articles  = 'http://cms.dmngd.co/api/collection/4d25745aed1ff505038777d6e75fdb39/main-articles/order/-createdOn'
nav       = 'http://cms.dmngd.co/api/collection/4d25745aed1ff505038777d6e75fdb39/main-navigation/order/order'
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
                data.navigation = navres.body.records
                data.articles = articles.body.records
                console.log data
                res.render 'index', data
