_default:
    #!/usr/bin/bash

# just test the just files
test-just-files:
  # yoinked from https://github.com/ublue-os/just-action/
  find "./" -type f -name "*.just" | while read -r file; do
    echo "Checking syntax: $file"
    just --unstable --fmt --check -f $file || { exit 1; }
  done

# just do a one-off local test build
local-build:
    podman build -t myBazziteImageTestBuild .

# just explore the one-off local test build
explore-local-build:
  podman run -it --rm --name myBazziteLocalImageTest myBazziteImageTestBuild /usr/bin/bash

# just explore the build on ghcr
explore-gh-build:
  podman run -it --rm --name myBazziteGhcrImageTest ghcr.io/vibrantleaf/my-personal-bazzite:latest /usr/bin/bash

# just remove the one-off local test build
remove-local-build:
  podman image rm -f myBazziteImageTestBuild
  podman image rm -f ghcr.io/ublue-os/bazzite

# just remove the build on ghcr
remove-local-build:
  podman image rm -f ghcr.io/vibrantleaf/my-personal-bazzite
