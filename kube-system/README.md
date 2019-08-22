# kube-system Specific Installs

## sealed-secrets

Once installed with flux for the first time, grab the public cert: 

```
kubeseal --fetch-cert \
--controller-name=sealed-secrets \
--controller-namespace=kube-system \
> pub-cert.pem
```

TODO: Backup private cert for migrations.


