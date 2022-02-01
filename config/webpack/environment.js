const { environment } = require('@rails/webpacker')

const CSSLoader = environment.loaders
  .get('moduleSass')
  .use
  .find((el) => el.loader === 'css-loader')

module.exports = environment
