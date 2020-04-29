# roach_clip

`roach_clip` provides utilities, and installation scripts to run Temporal database backend using cockroachdb for high availability

# installation

Run `make install`

# Setup

To setup the certificates you'll want to generate at a minimum:

* CA Key + Cert
* Node Key + Cert
* Client Key + Cert


```shell
$> ./gen_certs.sh ca ./cert-dir ./ca-key-dir
$> ./gen_certs.sh node ./cert-dir ./ca-key-dir/ca.key 192.168.1.201
$> ./gen_certs.sh client ./cert-dir ./ca-key-dir/ca.key temporal
```

## Single Node Test

After generating the certificates you can deploy a single node cockroach cluster with

```shell
$> cockroach start-single --certs-dir=cert-dir --listen-addr=localhost:26257 --http-addr=localhost:8080 --background
```

# NOtes

* [golang + gorm + cockroachdb](https://www.cockroachlabs.com/docs/stable/build-a-go-app-with-cockroachdb-gorm.html)
* [certificate information](https://www.cockroachlabs.com/docs/v19.2/cockroach-cert.html)
* [cockroach sql information](https://www.cockroachlabs.com/docs/v19.2/cockroach-sql.html)
* [permission grants](https://forum.cockroachlabs.com/t/grants-question/329)
* [creating a user with database access](https://forum.cockroachlabs.com/t/creating-a-user-with-database-access/2951)