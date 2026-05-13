#!/bin/bash

killall zsh
exec rm "$HISTFILE"
