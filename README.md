# MinIO Public Files

一个独立的 MinIO Docker 部署项目，用于托管可匿名下载的公开文件。

## 目录结构

```text
.
├── .env.example
├── CHANGELOG.md
├── compose.yaml
├── Makefile
├── README.md
├── scripts/
│   ├── compose.sh
│   └── init-public-bucket.sh
└── data/
```

## 功能

- 启动 MinIO API，默认端口 `19000`
- 将 MinIO Console 仅绑定到本机 `127.0.0.1:19001`
- 启动后自动创建公开桶 `MINIO_PUBLIC_BUCKET`
- 自动为该桶设置匿名下载策略

## 环境要求

- Docker
- `docker compose` 或 `docker-compose`
- 可选：`mc`，用于上传和管理对象

项目使用标准 Compose 文件名 `compose.yaml`。

## 快速开始

```bash
cp .env.example .env
$EDITOR .env
make up
make ps
```

服务启动后：

- S3 API / 文件访问：`http://<host>:19000`
- Console：`http://127.0.0.1:19001`

公开文件 URL 格式：

```text
http://<host>:19000/<bucket>/<path-to-file>
```

## 常用命令

```bash
make up
make down
make restart
make ps
make logs
make config
make public-url
```

如果不想使用 `make`，也可以直接运行：

```bash
./scripts/compose.sh up -d
./scripts/compose.sh logs -f minio
./scripts/compose.sh down
```

## 上传文件

先为 `mc` 配置别名：

```bash
mc alias set local http://127.0.0.1:19000 <MINIO_ROOT_USER> <MINIO_ROOT_PASSWORD>
```

上传到公开桶：

```bash
mc cp /path/to/file local/<MINIO_PUBLIC_BUCKET>/path/to/file
```

## 对外网开放

1. 将公网端口转发到本机 `MINIO_API_PORT`
2. 放通主机防火墙对应端口
3. 对外使用时，直接使用你的公网 IP 或域名拼接文件 URL：

```text
http://<your-public-host>:19000/<bucket>/<path-to-file>
```

4. 如需调整端口或控制台地址，修改 `.env` 后执行 `make restart`

## 说明

- 数据目录为 `./data`，默认不纳入 Git
- `.env` 包含凭据，默认不纳入 Git
- 当前默认端口为 `19000/19001`，避免和本机常见的 `9000/9001` 冲突
