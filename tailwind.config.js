module.exports = {
  purge: ['./app/views/**/*.erb','./app/stylesheets/*.scss','./app/components/*.erb',],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        pls: {
          light: '#CFF09E',
          DEFAULT: '#0B486B',
          strong: '#3B8686  ',
        }
      }
    }
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
