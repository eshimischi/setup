#!/usr/bin/env bash

# Title
echo "Setup NVS"

# Specify the installation path
export NVS_HOME="$HOME/.nvs"

if [ ! -d "$NVS_HOME" ]; then

	# Clone NVS repository
	git clone https://github.com/jasongin/nvs "$NVS_HOME"

	# Set 777 mode
	sudo chmod -R 777 $NVS_HOME

	[ -s "$NVS_HOME/nvs.sh" ] && . "$NVS_HOME/nvs.sh"

	# Configs

	if nvs --version > /dev/null 2>&1; then
  		nvs add 8.12.0
  		nvs link 8.12.0
	fi

	if which npm > /dev/null 2>&1; then

  		if which python2 > /dev/null 2>&1; then
    		npm config set python "$(which python2)"
  		fi

  		npm config set init.author.name 'Dmitry Laskin'
  		npm config set init.author.email 'eshimischi@gmail.com'
  		npm config set init.author.url 'https://github.com/eshimischi'

  		npm config set send-metrics true

  		NPM_FAVOURITES=(
			"@antora/cli"
			"@antora/site-generator-default"
  			"@nestjs/cli"
  			"@types/google-protobuf"
  			"ajv"
			"appdmg"
			"asar"
      		"electron-builder"
      		"gulp"
      		"lerna"
      		"node-gyp"
      		"assemblyscript"
      		"autorest"
			"capnpc-ts"
      		"google-protobuf"
      		"graphql-cli"
			"grpc"
      		"grpc-web-client"
      		"node-pre-gyp"
      		"parcel-bundler"
      		"prisma"
      		"protoc-gen-grpc-ts"
      		"reflect-metadata"
      		"snyk"
      		"npm-check-updates"
			"protoc-gen-grpc-ts"
      		"ts-protoc-gen"
      		"wabt"
      		"wtfwith"
			"release-it"
      		"update"
      		"typewiz-node"
      		"typesync"
      		"type-graphql"
      		"to"
      		"js-to-mjs"
      		"nw-builder"
      		"nw-gyp"
      		"nwjs"
      		"prettier"
			"rxjs"
			"semantic-release-cli"
      		"typeorm"
      		"typescript"
      		"tslint"
      		"vue-cli"
  		)

  		echo 'updating NPM and packages...'
  		set +e # private packages will fail on incorrect networks, ignore this
  		npm update --global
  		set -e

  		echo 'installing favourite NPM packages...'
  		INSTALLED_FAVOURITES=$(npm ls --global --depth=0)
  		for FAV in "${NPM_FAVOURITES[@]}"; do
    		if ! echo "${INSTALLED_FAVOURITES}" | grep " ${FAV}@" > /dev/null 2>&1; then
      			npm install --global $FAV
    		fi
  		done

	fi

	if which node > /dev/null 2>&1; then
  		if which node-gyp > /dev/null 2>&1; then
    		node-gyp install "$(node --version)"
    		nw install 0.34.2-sdk
  		fi
	fi

	if [ -d ~/.config/yarn/global ]; then
  		rm -rf "${HOME}/.config/yarn/global"
	fi
fi
