# Publish docker action

This action publish docker image to your registry

## Inputs

### `username`
**Required** username for container registry authentication .

### `password`
**Required** password for container registry authentication.

### `repository`
**Required** Github repository name 

### `docker_repository`
**Required** Container registry repository name 

### `registry`
**Required** Hostname of the container repository

### `pat_string`
**Required** Github Personal Access Token string in `https://[USERNAME]:[PERSONAL_ACCESS_TOKEN]@github.com` format 

### `tag`
Image tag. If you don't want to set, it is set to `latest`

## Outputs

### `image`
Tagged image name

## Example usage 

```yaml
    uses: spi-dot-dev/docker-action@master 
    with: # These are injested as arguments in docker-action/entrypoint.sh
        username: ${{ secrets.DOCKER_USERNAME }} 
        password: ${{ secrets.DOCKER_PASSWORD }}
        repository: ${{ github.repository }} 
        docker_repository: 'dockerhub-username/repo-name'
        registry: registry.hub.docker.com 
        pat_string: ${{ secrets.PAT_STRING }}
        tag: ${{ github.ref }} # or specify yourself!
        # To use github's container repository replace
        # registry: docker.pkg.github.com
        # repository: user/test-repo/test-app
```
A full example can be found in the  `/workflows/example.yml` file