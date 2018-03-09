var gulp = require('gulp');
var elm = require('gulp-elm');
var gutil = require('gulp-util');
var plumber = require('gulp-plumber');
var connect = require('gulp-connect');
var clean = require('gulp-clean');

// File paths
var paths = {
  dest: 'dist',
  elm: 'src/Main.elm',
  static: 'src/*.{html,css}'
};

// Init Elm
gulp.task('elm-init', elm.init);
 
// Compile Elm
gulp.task('elm', ['elm-init'], function(){
    return gulp.src(paths.elm)
        .pipe(plumber())
        .pipe(elm())
        .pipe(gulp.dest(paths.dest));
});

// Move static assets to dist
gulp.task('static', function() {
    return gulp.src(paths.static)
        .pipe(plumber())
        .pipe(gulp.dest(paths.dest));
});

gulp.task('clean-static', function() {
    return gulp.src(paths.dest, {read: false})
        .pipe(plumber())
        .pipe(clean())
})

// Watch for changes and compile
gulp.task('watch', function() {
    gulp.watch(paths.elm, ['elm']);
    gulp.watch(paths.static, ['static']);
});

// Local server
gulp.task('connect', function() {
    connect.server({
        root: 'dist',
        port: 8000
    });
});

// Main gulp tasks
gulp.task('clean', ['clean-static'])
gulp.task('build', ['elm', 'static']);
gulp.task('default', ['connect', 'build', 'watch']);