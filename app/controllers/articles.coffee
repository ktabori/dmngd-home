express         = require 'express'
unirest         = require 'unirest'
router          = express.Router()

nav             = 'https://api.airtable.com/v0/appVv3qQJXVr4clNx/Top Navigation Items?limit=100&view=Dmngd Navigation'

module.exports = (app) ->
  app.use '/article', router

  router.get '/:slug?', (req, res, next) ->

    if req.params.slug
      slug = req.params.slug
    else
      res.render "error"

    unirest.get nav
      .headers ({'Authorization': 'Bearer keyji9aGN0OHwZzZc'})
      .end (navres) ->

        data = {}
        data.pageTitle = 'Article'
        data.navigation = navres.body.records
        
        view = 'articles/' + slug
        res.render view, data
