#!/bin/bash
CURRENT_DIR="$PWD"

IMAGE_VERSION="0.2.0"

IDE_CHILD_PROJECT_DIR="/Users/carter/qed9/qed-bitcoin-ide/apps/ide-child"
BITIDE_PROJECT_DIR="/Users/carter/qed9/qed-bitcoin-ide/apps/bitcoin-ide"


build_ide_child(){
  cd "$IDE_CHILD_PROJECT_DIR"
  pnpm build

  cd "$CURRENT_DIR"
  rm -rf ./static/ide-child
  cp -r "${IDE_CHILD_PROJECT_DIR}/dist" ./static/ide-child

  REPLACED_INDEX=$(sed 's/src="\/assets/src="assets/' ./static/ide-child/index.html)
  echo "$REPLACED_INDEX" > ./static/ide-child/index.html
}

build_bitide() {
  cd "$BITIDE_PROJECT_DIR"
  pnpm build

  cd "$CURRENT_DIR"
  rm -rf ./static/bitide
  cp -r "${BITIDE_PROJECT_DIR}/dist" ./static/bitide

  REPLACED_INDEX=$(sed 's/window.__DOGE_DEFAULT_MODE__=false/window.__DOGE_DEFAULT_MODE__=true/g' ./static/bitide/index.html)
  echo "$REPLACED_INDEX" > ./static/bitide/index.html
  REPLACED_INDEX=$(sed 's/The Bitcoin IDE/The Dogecoin IDE/g' ./static/bitide/index.html)
  echo "$REPLACED_INDEX" > ./static/bitide/index.html
}


build_docker() {
  cd "$CURRENT_DIR"
  docker build -t qedprotocol/bitide-doge:latest .
  docker tag qedprotocol/bitide-doge:latest "qedprotocol/bitide-doge:$IMAGE_VERSION"
}

push_docker() {
  docker push "qedprotocol/bitide-doge:$IMAGE_VERSION"
  sleep 2
  docker push qedprotocol/bitide-doge:latest
}

run_all() {
  #build_ide_child
  #build_bitide
  build_docker
  #push_docker
}

run_all