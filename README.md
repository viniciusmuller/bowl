# Bowl

Bowl is a simple distributed key-value storage, that leverages the elixir/erlang
ecosystem in order to get its functionalities.

It uses [Nebulex](https://github.com/cabol/nebulex) in order to get the caching
capabilities, [libcluster](https://github.com/bitwalker/libcluster) to build the
cluster and [Phoenix](https://www.phoenixframework.org/) to provide a simple
HTTP interface.

## Developing

```
# Enter the nix development environment
nix develop

# Run the server
iex -S mix phx.server
```

## Deploying to Kubernetes

The following object creates a deployment for bowl with 3 instances, a [headless
service](https://kubernetes.io/docs/concepts/services-networking/service/#headless-services)
for service discovery, and a service for load balancing between the instances.

```
kubectl create -f ./k8s/deployment_and_services.yml
```

Once the pods are running, they will connect to each other and form a cluster,
which will be used to distribute the load and replicate the cache, so a key that
is set in *node A* will also be visible from *node B*.

## TODO
- [ ] Improve HTTP interface (Add metadata endpoint)
- [ ] Metrics
- [x] Cache Endpoint and simple tests
- [x] K8s deploy
- [x] Distribution with libcluster
