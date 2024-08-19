_default:
  just --list

dist := "themes"

clean:
  rm -rfv {{dist}}

build: clean
  whiskers templates/accent.tera
  whiskers templates/main.tera
  whiskers templates/theme.tera
