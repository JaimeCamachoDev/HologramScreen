
![HologramUI](https://github.com/user-attachments/assets/e0e909a3-2417-4444-af28-f5d7b602e3cc)

# HologramScreen

**Shader de pantalla holográfica para Unity 6 (URP)**
*Efecto de profundidad falsa con Cubemap para interfaces sci-fi.*

</div>

## Descripción

**HologramScreen** es un proyecto de Unity centrado en la creación de un efecto visual de **pantalla holográfica** utilizando **Shader Graph** en **Universal Render Pipeline (URP)**.
El objetivo principal es simular una sensación de volumen/profundidad dentro de una superficie 2D mediante técnicas de fake depth con cubemap.

Este repositorio funciona como base reutilizable para:

- Interfaces futuristas dentro de escenas 3D.
- Prototipos de HUD/terminales holográficas.
- Experimentación con VFX y materiales de estilo sci-fi.

---

## Características

- ✅ Shader holográfico en Shader Graph (URP).
- ✅ Materiales y assets de apoyo para iteración rápida.
- ✅ Escenas de ejemplo para prueba (`Main` y `Guiller`).
- ✅ Estructura de proyecto organizada por áreas (`Programming`, `Art`, `Scenes`, `Settings`).
- ✅ Soporte para VFX Graph en el proyecto.

---

## Requisitos

- **Unity Editor:** `6000.3.10f1` (Unity 6)
- **Render Pipeline:** Universal Render Pipeline (URP)
- **Paquetes principales:**
  - `com.unity.render-pipelines.universal` `17.3.0`
  - `com.unity.visualeffectgraph` `17.3.0`
  - `com.unity.recorder` `5.1.5`

> Recomendación: abrir el proyecto con la misma versión de Unity para evitar migraciones automáticas de assets o shaders.

---

## Estructura del proyecto

```text
Assets/
├── 1-Programming/
├── 2-Art/
│   ├── 2-VFX/
│   │   ├── Hologram_Screen/
│   │   └── Hologram_Sci-Fi_Screen(Tut)/
├── 3-Scenes/
│   ├── Main.unity
│   └── Guiller.unity
├── 4-Presets/
└── 5-Settings/
```

---

## Instalación y uso

1. **Clona** este repositorio:

   ```bash
   git clone https://github.com/<tu-usuario>/HologramScreen.git
   ```

2. Abre Unity Hub y selecciona **Add project from disk**.
3. Elige la carpeta del repositorio.
4. Abre el proyecto con **Unity 6000.3.10f1**.
5. Carga la escena `Assets/3-Scenes/Main.unity` para comenzar.

---

## Personalización rápida

Puedes ajustar el look del holograma modificando:

- Intensidad/emisión del material holográfico.
- Texturas de grid/noise.
- Parámetros de distorsión y scrolling.
- Color grading/postproceso en el perfil de volumen.

---

## Roadmap sugerido

- [ ] Añadir documentación de parámetros del shader (tabla de propiedades).
- [ ] Incluir presets visuales (clean, glitch, high-energy).
- [ ] Exportar paquete `.unitypackage` para integración rápida.
- [ ] Publicar demo en video/GIF en el README.

---

## Licencia

Este proyecto está bajo la licencia **MIT**. Consulta el archivo [LICENSE](LICENSE) para más detalles.

---

## Autor

Desarrollado por **Jaime Camacho**.
Si usas este proyecto como base, considera dejar créditos o compartir mejoras vía PR.
