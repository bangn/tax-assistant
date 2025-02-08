module.exports = {
  content: [
    "./public/*.html",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.{erb,haml,html,slim}",
    "./config/initializers/heroicon.rb",
  ],
  theme: {
    extend: {
      fontFamily: {},
    },
  },
  plugins: [],
};
