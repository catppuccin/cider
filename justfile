_default:
  just --list

dist := "themes"

clean:
  rm -rfv {{dist}}

build: clean
  #!/usr/bin/env bash
  whiskers templates/cider.tera
  whiskers templates/theme.tera

  for theme in `ls -d {{dist}}/*/*`; do
    npm --prefix ./cider-themekit run build ../$theme;
    find $theme -maxdepth 1 -type f -delete;
    mv $theme/dist/theme.cider-theme $(dirname $theme)/$(basename $(dirname $theme))-$(basename $theme).cider-theme;
    rm -rf $theme;
  done
