docker run --name myblog --volume="$PWD:/srv/jekyll" -p 4000:4000 -d jekyll/jekyll jekyll serve
