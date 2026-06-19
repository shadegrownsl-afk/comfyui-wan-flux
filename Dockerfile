# Image ComfyUI serverless — Wan 2.2 (video) + Flux schnell (image)
# Base officielle worker-comfyui (handler API RunPod deja inclus).
FROM runpod/worker-comfyui:5.4.0-base

# --- Custom nodes utiles (encodage video) ---
RUN comfy-node-install comfyui-videohelpersuite comfyui-kjnodes

# =========================================================
#  VIDEO — Wan 2.2 TI2V-5B (texte->video ET image->video)
#  Modele unique, leger (~10 Go), 720p. Poids ouverts.
# =========================================================
RUN wget -q -O /comfyui/models/diffusion_models/wan2.2_ti2v_5B_fp16.safetensors \
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_ti2v_5B_fp16.safetensors"

RUN wget -q -O /comfyui/models/vae/wan2.2_vae.safetensors \
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan2.2_vae.safetensors"

RUN wget -q -O /comfyui/models/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors \
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors"

# =========================================================
#  IMAGE — Flux schnell (checkpoint fp8 tout-en-un, ~17 Go)
#  Apache-2.0, poids ouverts, pas de token requis.
# =========================================================
RUN wget -q -O /comfyui/models/checkpoints/flux1-schnell-fp8.safetensors \
    "https://huggingface.co/Comfy-Org/flux1-schnell/resolve/main/flux1-schnell-fp8.safetensors"

# Total modeles ~35 Go. Prevoir un container disk >= 60 Go cote endpoint.
