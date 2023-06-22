# octo-happiness
The helm chart for Dockerfile builds in the octo-happiness repos

<!-- ``sh
tkn hub install task rhacs-deployment-check
``` -->

## AMQ Broker functionality test

Install both applications, set the name of your AMQ Broker instance and you are good to go. 
The default image is fetched from `quay.io/modzelewski/octo-happiness-<design>`, in local registry use cases, set the imageOverride parameter. If you imported the image with a specific app version, set it in the `Chart.yaml` `appVersion`-variable.

Here the commands:

```sh
helm upgrade -i producer . --set design=mqtt-producer --set amqBrokerInstanceNameOverride=ex-aao --set imageOverride=re

helm upgrade -i processor . --set design=mqtt-processor --set amqBrokerInstanceNameOverride=ex-aao

oc get route -l app.kubernetes.io/instance=producer -o jsonpath='{.items[].spec.host}
```