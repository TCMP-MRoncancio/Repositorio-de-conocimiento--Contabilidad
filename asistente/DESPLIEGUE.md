# Asistente de Contabilidad TCM – Guía de despliegue

Página web con chat que responde preguntas usando la API de Claude y el banco de conocimiento del repositorio de GitHub. Quien pregunta no necesita cuenta de Claude: solo el enlace (y la clave de acceso, si la defines).

```
Navegador  ──►  Cloudflare Worker (worker.js)  ──►  API de Claude
                        │
                        └──►  GitHub: carpeta conocimiento/ + CLAUDE.md
```

El Worker relee el repositorio cada 10 minutos: lo que cambies en GitHub aparece solo, sin volver a desplegar.

## 1. Clave de la API de Claude

1. Crea una cuenta en https://console.anthropic.com (es independiente de claude.ai).
2. En **Billing**, carga saldo (con USD 5 alcanza para miles de preguntas con el modelo por defecto).
3. En **Limits**, define un límite de gasto mensual, por ejemplo USD 10. Así el costo nunca se dispara.
4. En **API Keys**, crea una clave y cópiala (empieza por `sk-ant-`). No la pegues en GitHub ni en ningún archivo.

## 2. Token de GitHub (solo si el repositorio es privado)

1. GitHub → Settings → Developer settings → Personal access tokens → **Fine-grained tokens** → Generate new token.
2. Repository access: **Only select repositories** → `Repositorio-de-conocimiento--Contabilidad`.
3. Permissions → Repository permissions → **Contents: Read-only**. Nada más.
4. Genera el token y cópialo.

## 3. Publicar el Worker (desde el navegador, sin instalar nada)

1. Crea una cuenta gratuita en https://dash.cloudflare.com.
2. Ve a **Workers & Pages** → **Create** → **Create Worker**. Ponle de nombre `asistente-contabilidad-tcm` y haz clic en **Deploy**.
3. Haz clic en **Edit code**, borra todo el código de ejemplo, pega el contenido completo de `worker.js` y haz clic en **Deploy**.
4. Ve a **Settings** → **Variables and Secrets** y agrega:

| Nombre | Tipo | Valor |
| --- | --- | --- |
| `ANTHROPIC_API_KEY` | Secret | La clave del paso 1 |
| `GITHUB_REPO` | Text | `TCMP-MRoncancio/Repositorio-de-conocimiento--Contabilidad` |
| `GITHUB_TOKEN` | Secret | El token del paso 2 (solo si el repo es privado) |
| `CLAVE_ACCESO` | Secret | Opcional: una clave que compartes con el equipo para que puedan preguntar |
| `MODELO` | Text | Opcional: `claude-haiku-5-5` (por defecto) o `claude-sonnet-5-5` para respuestas más elaboradas |

5. Guarda. El asistente queda en `https://asistente-contabilidad-tcm.<tu-subdominio>.workers.dev`. Comparte ese enlace.

El modelo Fable está bloqueado en el código por política de la organización (elevado coste).

### Alternativa por terminal

```powershell
npm install -g wrangler
wrangler login
wrangler secret put ANTHROPIC_API_KEY
wrangler secret put GITHUB_TOKEN      # solo si el repo es privado
wrangler secret put CLAVE_ACCESO      # opcional
wrangler deploy
```

## 4. Probar

- Abre el enlace y haz clic en una de las preguntas de ejemplo.
- Si aparece "No se encontró la carpeta conocimiento", revisa `GITHUB_REPO` y, si el repo es privado, `GITHUB_TOKEN`.
- Si aparece "Falta configurar ANTHROPIC_API_KEY", revisa que la variable sea de tipo Secret y que guardaste.
- `https://.../api/estado` muestra cuántos archivos de conocimiento cargó.

## Seguridad y costo

- La clave de API vive solo en Cloudflare; el navegador nunca la ve.
- Sin `CLAVE_ACCESO`, cualquiera con el enlace puede preguntar y consumir saldo. Defínela si el enlace puede circular fuera del equipo.
- El banco completo se envía en cada pregunta, pero va cacheado: las preguntas seguidas cuestan menos. El límite mensual de la consola es el tope real.
