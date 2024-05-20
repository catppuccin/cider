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

    for processing_dir in `ls -d {{release_dir}}/*/*/`; do \
        {{themekit_cmd}} $processing_dir; \
        find $processing_dir -maxdepth 1 -type f -delete; \
        mv $processing_dir/dist/* $processing_dir; \
        rm -rf $processing_dir/dist; \
    done

build-dev:
    for template_file in `ls {{template_path}}`; do \
        {{whiskers_cmd}} {{template_path}}/$template_file; \
    done