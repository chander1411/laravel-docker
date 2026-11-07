# laravel-docker

Entorno Docker para proyectos Laravel (PHP 8.3 + Node 22 + nginx).
Basado en `~/runaserver`, pero con puertos distintos (la web usa el 80 como runaserver: no correr ambos a la vez) para poder correr ambos a la vez.

## Uso

```
cd ~/Documents/laravel-docker
./laravel start
```

Coloca cada proyecto en `projects/<nombre>` y abre `http://localhost/<nombre>/public` (igual que runaserver)
(nginx resuelve cualquier carpeta de `projects/`, sin configurar nada por proyecto).

## Comandos

| Comando | Descripcion |
|---|---|
| `./laravel start / stop / restart` | Levantar / bajar contenedores |
| `./laravel rebuild` | Reconstruir imagenes (tras cambiar `PHP_VERSION`) |
| `./laravel new miapp` | `composer create-project laravel/laravel miapp` |
| `./laravel run composer install` | Ejecuta dentro del contenedor, en la carpeta actual |
| `./laravel run php artisan migrate` | Idem (hacerlo desde `projects/<nombre>`) |
| `./laravel run npm run build` | Node/npm tambien incluido |
| `./laravel shell` | Bash dentro del contenedor php |
| `./laravel logs [servicio]` | Logs |

Tip: `alias laravel=~/Documents/laravel-docker/laravel`.

## Proyecto existente (ej. el composer.json de ejemplo)

```
cd projects && git clone <repo> miapp && cd miapp
../../laravel run composer install
../../laravel run php artisan key:generate
```

Base de datos, Redis y correo: usa los que ya tengas (ej. el MySQL de runaserver o uno local).

## Puertos (host)

| Servicio | Puerto |
|---|---|
| Web | `:80` |

Config en `docker/.env` (se crea solo desde `.env.example`).

## Extensiones PHP

pdo_mysql, pdo_pgsql, mysqli, gd, zip, intl, bcmath, pcntl, exif, opcache, mbstring, redis.
