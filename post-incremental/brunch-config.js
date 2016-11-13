// See http://brunch.io for documentation.
module.exports = {
    files: {
        javascripts: {joinTo: 'app.js'},
        stylesheets: {joinTo: 'app.css'},
        templates: {joinTo: 'app.js'}
    },
    plugins: {
        sass: {
            mode: 'native'
        },
        uglify: {
            mangle: true,
            compress: true
        }
    }
};
