_default:
  just --list

dist := "themes"

clean:
  rm -rfv {{dist}}

alias dev := whiskers

whiskers: clean
  whiskers templates/globals.tera
  whiskers templates/theme.tera
  whiskers templates/dialogs.tera
  whiskers templates/modes.tera
  whiskers templates/tabs.tera

build: whiskers
  #!/usr/bin/env bash
  for theme in `ls -d {{dist}}/*/*`; do
    npm --prefix ./cider-themekit run build ../$theme;
    find $theme -maxdepth 1 -type f -delete;
    mv $theme/dist/theme.cider-theme $(dirname $theme)/$(basename $(dirname $theme))-$(basename $theme).cider-theme;
    rm -rf $theme;
  done
