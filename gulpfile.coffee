gulp = require 'gulp'
gutil = require 'gulp-util'
imagemin = require 'gulp-imagemin'
minifyHtml = require('gulp-minify-html')

gulp.task 'image-min', ->
  gulp.src(['out/images/**/*.png'])
    .pipe imagemin()
    .pipe gulp.dest 'out/images'
    .on 'error', gutil.log

gulp.task 'html-min', ->
  gulp.src('out/**/*.html')
    .pipe(minifyHtml())
    .pipe(gulp.dest('out'))

gulp.task 'default', ['html-min']
gulp.task 'minify', ['html-min']
