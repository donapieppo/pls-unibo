module.exports = { 
  content: ["./app/views/**/*.erb", "./app/assets/stylesheets/*.css", "./app/components/*.erb", "./app/components/**/*.erb"],
  theme: {
    extend: {
      colors: {
        pls: {
          light: '#CFF09E',
          DEFAULT: '#0B486B',
          strong: '#3B8686',
        }
      }
    }
  },
  plugins: [
    require('@tailwindcss/forms'),
  ],  
}
