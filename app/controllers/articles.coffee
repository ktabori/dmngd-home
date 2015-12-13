express   = require 'express'
unirest   = require 'unirest'
router    = express.Router()

nav       = 'http://cms.dmngd.co/api/collection/4d25745aed1ff505038777d6e75fdb39/main-navigation/order/order'

module.exports = (app) ->
  app.use '/article', router

  router.get '/:slug?', (req, res, next) ->

    if req.params.slug
      slug = req.params.slug
    else
      res.render "error"

    unirest.get nav
      .end (navres) ->

        data = {}
        data.pageTitle = 'Article'
        data.navigation = navres.body.records
        view = 'articles/' + slug
        res.render view, data
