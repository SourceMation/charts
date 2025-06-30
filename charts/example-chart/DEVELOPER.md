# For developers
 
## Installing from repo
 
```bash 
git clone git@github.com:SourceMation/charts.git
cd charts/charts/example-chart/

export RELEASE_NAMESPACE=example-chart
 
helm upgrade --install -n ${RELEASE_NAMESPACE} \
--create-namespace \ 
example-chart .
``` 

## Cleaning

```bash
helm uninstall -n ${RELEASE_NAMESPACE} example-chart
```


## Testing

```bash

```
