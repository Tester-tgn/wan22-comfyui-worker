FROM runpod/base:cuda12.1.1

WORKDIR /app

# 1) ComfyUI core
RUN git clone https://github.com/comfyanonymous/ComfyUI.git

# 2) WAN custom nodes (senin repo)
RUN cd ComfyUI/custom_nodes && \
    git clone https://github.com/Tester-tgn/wan22-comfyui-worker

# 3) Video helper (SaveVideo / CreateVideo için)
RUN cd ComfyUI/custom_nodes && \
    git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite

# 4) Python deps
RUN pip install --upgrade pip
RUN pip install runpod requests

CMD ["python", "-c", "print('ComfyUI image ready')"]
