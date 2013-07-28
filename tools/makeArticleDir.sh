if ! test -e ./src; then
    echo "src directory is already existing, makedir was skipped"
else
    mkdir -p ~/article && ln -s -d ~/article ./src
fi
