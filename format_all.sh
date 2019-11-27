#!/bin/bash

for file in *.{cpp,hpp} debug/*.hpp
do
    echo "Formatting file: $file ..."
    clang-format -style=file -i $file
done
