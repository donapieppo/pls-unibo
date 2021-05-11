module.exports = {
  purge: ['./app/views/**/*.erb','./app/stylesheets/*.scss','./app/components/*.erb',],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        pls: {
          light: '#00ffff',
          DEFAULT: '#99e633',
          strong: '#0033b3',
        }
      }
    }
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
