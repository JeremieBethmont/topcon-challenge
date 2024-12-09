# WORDPRESS APP

This is to illustrate a CI pipeline for Wordpress development.

In a real production environment the `app` directory should be hosted on a dedicated repository.

## Development

The custom code should be place under `./custom-plugin` and `./custom-theme`. Then the github actions workflow builds, test and publishes the container based on the `Dockerfile`.

## Workflow

The Github workflow watches any commit to the `/app/*` directory on the `main` branch. And executed the operations described bellow by the cli equivalents. In a real produc

1. Place your code under the [custom-plugin](./custom-plugin/) or [custom-theme](./custom-theme/) directories
2. Commit your code following the [semantic-release](https://github.com/semantic-release/semantic-release) conventions.

| Commit message                                                                                                                                                                                   | Release type                                                                                          |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------- |
| `fix(pencil): stop graphite breaking when too much pressure applied`                                                                                                                             |
| Fix Release                                                                                                                                                                                      |
| `feat(pencil): add 'graphiteWidth' option`                                                                                                                                                       | Feature Release                                                                                       |
| `perf(pencil): remove graphiteWidth option`<br><br>`BREAKING CHANGE: The graphiteWidth option has been removed.`<br>`The default graphite width of 10mm is always used for performance reasons.` | Breaking Release <br /> (Note that the `BREAKING CHANGE: ` token must be in the footer of the commit) |

1. Push the code to the `main` branch via a pull request
2. The github actions workflow will test, build and publish the new container image to ECR.
3. Capture the "tag" version to update the helm deployment if necesarry (or use `latest`)