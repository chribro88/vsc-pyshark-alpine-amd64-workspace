# PyShark VS Code Remote Development Container 
 - with Miniconda & Docker
 - Alpine 3.18
 - AMD64

Prerequisistes:
 - Follow steps 1-3 on https://github.com/chribro88/vsc-alpine-amd64-workspace

Build:
1. https://github.com/chribro88/vsc-alpine-amd64-workspace

```
docker build --build-arg REGISTRY_HOST=<REGISTRY_HOST>/ --build-arg REGISTRY_USERNAME=<REGISTRY_USERNAME>/ --build-arg BASE_VERSION=3.18 -f .devcontainer/Dockerfile https://github.com/chribro88/vsc-alpine-amd64-workspace.git -t [<REGISTRY_HOST>/][<REGISTRY_USERNAME>/]vsc-alpine-amd64-workspace[:<BASE_VERSION>]

# optional - tag and send to local registry
docker tag vsc-alpine-amd64-workspace[:<BASE_VERSION>] [<REGISTRY_HOST>/][<REGISTRY_USERNAME>/]vsc-alpine-amd64-workspacec[:<BASE_VERSION>]
docker push  [<REGISTRY_HOST>/][<REGISTRY_USERNAME>/]vsc-alpine-amd64-workspace[:<BASE_VERSION>]
```

2. Update `devcontainer.json`, `settings.json` and `Dockerfile`:
   - devcontainer.json
     - LOCAL_USERNAME
     - PATH
     - REGISTRY_HOST
     - REGISTRY_USERNAME
     - BASE_VERSION
   - settings.json
     - DOCKER_HOST
   - Dockerfile
     - DOCKER_GID

3. Reopen container in vscode (you may need image on local docker host so pull if not)
```
docker pull  [<REGISTRY_HOST>/][<REGISTRY_USERNAME>/]vsc-alpine-amd64-workspace[:<BASE_VERSION>]
```

NB:
  - VS Code will prefix 'vsc-' to the local directory for the image name, so you may want to do: 
```
git clone https://github.com/chribro88/vsc-pyshark-alpine-amd64-workspace.git
mv vsc-pyshark-alpine-amd64-workspace pyshark-alpine-amd64-workspace
```
  - otherwise image will be 'vsc-vsc-pyshark-alpine-amd64-workspace-<some hash>'

 # Follow up
 Seems better to prebuild the image on the docker host, then add the image to the devcontainer.json
 
 ```
 docker build \
	  --build-arg USERNAME=<USERNAME> \
	  --build-arg USER_UID=<USER_UID> \
	  --build-arg REGISTRY_HOST=<REGISTRY_HOST> \ \\ inlcude forwardslash ('/')
	  --build-arg REGISTRY_USERNAME=<REGISTRY_USERNAME> \ \\ inlcude forwardslash ('/')
	  --build-arg BASE_VERSION=<BASE_VERSION> \
	  -f .devcontainer/Dockerfile \
	  https://github.com/chribro88/vsc-pyshark-alpine-amd64-workspace.git \
	  -t vsc-pyshark-alpine-amd64-workspace:3.18 \
	  --no-cache
 ```
# Conda Environment
The postCreateCommand.sh will run when the dev container is created. This will move the environment.yml from /tmp/conda-tmp/ to the /workspace/.conda/ (if it doesn't exist) which will persist on the docker host. You can update the ennvironment.yml and rebuild with the new modules.
