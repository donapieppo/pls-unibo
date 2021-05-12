const { environment } = require('@rails/webpacker')

module.exports = environment
environment.config.output.publicPath = "/packs/";

