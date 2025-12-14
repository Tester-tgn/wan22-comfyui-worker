#!/bin/bash

echo "🚀 Starting ComfyUI with Wan models..."
echo "📂 Models path: $COMFYUI_MODELS_PATH"

# Volume'daki models klasörünü ComfyUI'nin beklediği yere link et
if [ -d "/workspace/runpod-slim/ComfyUI/models" ]; then
    echo "✅ Found models in volume!"
    
    # Eski models klasörünü yedekle
    if [ -d "/comfyui/models" ]; then
        mv /comfyui/models /comfyui/models.backup
    fi
    
    # Volume'daki models'i link et
    ln -sf /workspace/runpod-slim/ComfyUI/models /comfyui/models
    
    echo "🔗 Models linked successfully!"
    ls -la /comfyui/models/
else
    echo "⚠️ Volume models not found at /workspace/runpod-slim/ComfyUI/models"
fi

# ComfyUI'yi başlat (orijinal entrypoint)
echo "▶️ Starting ComfyUI..."
exec /start.sh
