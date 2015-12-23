express   = require 'express'
unirest   = require 'unirest'
router    = express.Router()

nav       = 'https://api.fieldbook.com/v1/567b129370964203001b2a3f/main_navigation'

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
        data.navigation = navres.body
        view = 'articles/' + slug
        res.render view, data
