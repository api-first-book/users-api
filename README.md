# Users API

書籍『APIファースト ─ Postmanで学ぶ効率的かつ柔軟な開発アプローチ』の第8章「Postman Insights」で使用するサンプルAPI「Users API」のアプリケーションリポジトリです。
このUsers APIは、FlaskとMySQLを使って構築されたアプリケーションで、[kubernetes-flask-mysql](https://github.com/Rikkraan/kubernetes-flask-mysql)をベースにしたフォーク版です。

## Quickstart

ローカル環境でgitコマンドが使える人は下記のようにgit cloneしてください。

```bash
git clone https://github.com/api-first-book/users-api.git
```

なお、gitコマンドがない方は、直接[こちら](https://github.com/api-first-book/users-api)よりダウンロードしてください。

次に、下記のようにkindコマンドでKubernetes (k8s) クラスターを作成してください。

```bash
kind create cluster --image kindest/node:v1.30.0 --config=kubernetes/kind/cluster.yaml --wait 5m
```

次のコマンドでk8sクラスターが期待通り作成されていることを確認します。

```bash
$ kind get cluster

kind
```

次のコマンドで、すべてのk8sリソースをk8sクラスターにデプロイします。

```bash
kubectl apply -f kubernetes/users-api-all-in-one.yml

# Or you can apply one by one like this:
# kubectl apply -f mysql-pv.yml
# kubectl apply -f mysql-deployment.yml
# kubectl apply -f app-secrets.yml
# kubectl apply -f app-deployment.yml
```

次のコマンドで、すべてのPodsが稼働している (running) ことを確認します。

```bash
kubectl get po

NAME                                   READY   STATUS    RESTARTS   AGE
usersapi-59bcb745ff-sfdtf              1/1     Running   2          7m53s
mysql-6b47c788c6-blzlc                 1/1     Running   0          7m43s
```

最後に、`svc/users`のポート`5000`をローカルホストの`8080`番ポートにポートフォワードします。

```bash
kubectl port-forward svc/usersapi 8080:5000
```

すべての設定が完了したので、下記のようにサービスにアクセスできるようになりました。

```bash
curl http://localhost:8080/users
```
