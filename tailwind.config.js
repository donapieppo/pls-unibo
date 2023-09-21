const colors = require('tailwindcss/colors')

module.exports = { 
  content: ["./app/views/**/*.erb", "./app/assets/stylesheets/*.css", "./app/components/*.erb", "./app/components/*.rb", "./app/components/**/*.erb", "./app/components/**/*.rb"],
  theme: {
    colors: {
      gray: colors.gray,
      white: colors.white,
      blue: colors.blue,
      red: colors.red,
      black: colors.black,
      yellow: colors.yellow,
      green: colors.green,
      orange: colors.orange, 
      home: {
        title: '#040D12',
        bg1: '#93B1A6',
      }, 
      pls: {
        title: '#040D12',
        white: 'rgb(247, 249, 251)',
        light: '#93B1A6',
        DEFAULT: '#183D3D',
        strong: '#040D12',
        flash: '#F09C2C', 
      },
      button: {
        DEFAULT: 'rgb(247, 249, 251)',
        hover: '#9DB2BF'
      }
    }
  },
  plugins: [
    require('@tailwindcss/forms'),
  ],  
}
