// Note: You must restart bin/webpack-watcher for changes to take effect

const merge = require('webpack-merge')
const sharedConfig = require('./shared.js')

module.exports = merge(sharedConfig, {
  devtool: 'sourcemap',

  stats: {
    errorDetails: true
  },

  module: {
    rules: [
      {
        enforce: 'pre',
        test: /\.js?$/,
        use: [
          { loader: 'eslint-loader' },
        ],
        exclude: /node_modules/,
      },
    ]
  },

  output: {
    pathinfo: true
  }
})
