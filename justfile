_default:
    just --list

release_dir := "themes"
whiskers_cmd := "whiskers"
themekit_cmd := "npm run build"
template_path := "templates"

clean:
    rm -rfv {{release_dir}}

build:
    for template_file in `ls {{template_path}}`; do \
        {{whiskers_cmd}} {{template_path}}/$template_file; \
    done

    for processing_dir in `ls -d themes/*/*/`; do \
        npm run build $processing_dir; \
        find $processing_dir -maxdepth 1 -type f -delete; \
        mv $processing_dir/dist/theme.cider-theme $(dirname $processing_dir)/$(basename $(dirname $processing_dir))-$(basename $processing_dir).cider-theme; \
        rm -rf $processing_dir; \
    done

build-dev:
    for template_file in `ls {{template_path}}`; do \
        {{whiskers_cmd}} {{template_path}}/$template_file; \
    done