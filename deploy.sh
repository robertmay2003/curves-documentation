rm -rf build
hugo
cd build && git add --all && git commit -m "Publishing to gh-pages" && cd ..
git push origin gh-pages