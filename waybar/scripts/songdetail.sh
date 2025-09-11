#!/bin/bash

json=$(playerctl metadata --format '{"text": "{{title}}      {{artist}}", "tooltip": "Listening to {{title}} by {{artist}}"}')
echo $json

