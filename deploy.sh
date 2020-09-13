rm -rf build
hugo -D
cd build && git add --all && git commit -m "Publishing to gh-pages" && cd ..
git push origin gh-pages