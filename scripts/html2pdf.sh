#!/bin/sh

echo "Building tool to generate PDF from HTML page"
echo

isinstalled=$(which "wkhtmltopdf")
if [ -z "$isinstalled" ]
then
  echo "Missing dependency:"
  echo "  1. Install wkhtmltopdf from http://wkhtmltopdf.org/downloads.html"
  echo "  2. Make sure wkhtmltopdf's bin directory is in your PATH"
  exit 1
fi

if [ -n "$http_proxy" ]
then
  PROXY="--proxy $http_proxy"
fi
#INPUT=http://globalplatform.github.io/WebApis-for-SE/doc/
INPUT=doc/index.html
OUTPUT=build/WebAPI-for-SE-v1.0.pdf

echo "INPUT: $INPUT"
echo "OUTPUT: $OUTPUT"
echo "Processing..."

mkdir -p build
wkhtmltopdf $PROXY --user-style-sheet scripts/for-pdf.css --header-left 'Web API For Accessing Secure Element - v1.0' --header-right '[page]/[toPage]' --header-line --margin-top 2.3cm --header-spacing 8 --header-font-size 10 --footer-line --footer-font-name 'Times New Roman' --footer-font-size 10 --footer-spacing 8 --margin-bottom 2.3cm  --footer-center 'Copyright © 2016 GlobalPlatform Inc. All Rights Reserved.' --debug-javascript  $INPUT $OUTPUT
