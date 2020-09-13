rm -rf build
hugo -D
cd build && git add --all && git commit -m "Publishing to gh-pages" && git push origin gh-pages && cd ..