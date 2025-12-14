import os
import time
import subprocess
import requests
import runpod

# === PATHLER (SENİN VERDİĞİN) ===
COMFY_DIR = "/app/ComfyUI"
COMFY_API = "http://127.0.0.1:8188"

MODELS_SRC = "/workspace/runpod-slim/ComfyUI/models"
MODELS_DST = f"{COMFY_DIR}/models"


def link_models():
    """
    Modelleri ComfyUI/models altına symlink eder
    """
    if os.path.exists(MODELS_DST):
        print("ℹ️ Models path already exists, skipping symlink")
        return

    if not os.path.exists(MODELS_SRC):
        raise RuntimeError(f"❌ Model source path not found: {MODELS_SRC}")

    os.symlink(MODELS_SRC, MODELS_DST)
    print(f"✅ Symlink created: {MODELS_SRC} -> {MODELS_DST}")


def start_comfyui():
    """
    ComfyUI'yi headless başlatır
    """
    print("🚀 Starting ComfyUI...")
    subprocess.Popen(
        ["python", "main.py", "--listen", "0.0.0.0"],
        cwd=COMFY_DIR
    )


def wait_for_comfyui(timeout=60):
    """
    ComfyUI API ayağa kalkana kadar bekler
    """
    print("⏳ Waiting for ComfyUI API...")
    start = time.time()

    while time.time() - start < timeout:
        try:
            r = requests.get(COMFY_API, timeout=2)
            if r.status_code == 200:
                print("✅ ComfyUI API is ready")
                return
        except Exception:
            pass
        time.sleep(1)

    raise RuntimeError("❌ ComfyUI API did not start in time")


def handler(event):
    """
    RunPod Serverless handler
    """
    print("📩 Job received")

    link_models()
    start_comfyui()
    wait_for_comfyui()

    return {
        "status": "ok",
        "message": "ComfyUI started, models symlinked successfully"
    }


runpod.serverless.start({
    "handler": handler
})
