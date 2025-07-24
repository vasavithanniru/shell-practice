#!/bin/bash

FRUITES=("apple", "kiwi", "orange")  #index starts from 0, size is 3

echo "first fruite is: ${FRUITES[0]}"
echo "second fruite is: ${FRUITES[1]}"
echo "third fruite is: ${FRUITES[2]}"

echo "all fruite names: ${FRUITES[@]} "
