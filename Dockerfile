FROM runpod/worker-comfyui:5.6.0-base

# Startup script'ini kopyala
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

# Volume path'lerini ayarla
ENV COMFYUI_PATH=/comfyui
ENV COMFYUI_MODELS_PATH=/workspace/runpod-slim/ComfyUI/models
ENV COMFYUI_INPUT_PATH=/workspace/runpod-slim/ComfyUI/input
ENV COMFYUI_OUTPUT_PATH=/workspace/runpod-slim/ComfyUI/output

# Startup script ile başlat
ENTRYPOINT ["/startup.sh"]
