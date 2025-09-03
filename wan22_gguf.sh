#!/bin/bash

#sudo apt update; sudo apt install python3.10-venv
#python3 -m venv comfyui-env
#comfy install
#sudo ufw enable
#sudo ufw allow 22
#sudo ufw allow 8188
source /home/user/comfyui-env/bin/activate
WORKSPACE=/home/user/comfy
COMFYUI_DIR=${WORKSPACE}/ComfyUI
CIVIT_CLI_DIR=${WORKSPACE}/civitai-models-cli
MODELS_DIR=${COMFYUI_DIR}/models/
CIVIT_ENV_DIR=~/.civitai-model-manager
CIVIT_CLI_ENV=${CIVIT_ENV_DIR}/.env
APT_PACKAGES=(
    "nano"
    "Python3.12-dev"
    "build-essential"
    "gcloud"
    "apt-transport-https"
    "ca-certificates"
    "gnupg"
    "curl"
)
PIP_PACKAGES=(
    "comfy-cli"
    "sageattention"
)
NODES=(
    # cg-use-everywhere
    # cg-image-filter
    # ComfyMath
    # ComfyUI-Addoor
    # comfyui-art-venture
    # ComfyUI_Comfyroll_CustomNodes
    # ComfyUI-Custom-Scripts
    # comfyui-dream-project
    # Comfyui-ergouzi-Nodes
    # comfyui-florence2
    # ComfyUI-FramePackWrapper_PlusOne
    # ComfyUI-GIMM-VFI
    # comfyui_HavocsCall_Custom_Nodes
    # comfyui-image-selector
    # comfyui-impact-pack
    # comfyui-inspire-pack
    # ComfyUI_JPS-Nodes
    # comfyui_memory_cleanup
    # comfyui-ollama
    # comfyui-reactor
    # comfyui_tinyterranodes
    # comfyui-various
    # ComfyUI-VideoHelperSuite
    # comfyui-vrgamedevgirl
    # derfuu_comfyui_moddednodes
    # efficiency-nodes-comfyui
    # masquerade-nodes-comfyui
    # was-node-suite-comfyui
    # wywywywy-pause
    "https://github.com/Acly/comfyui-inpaint-nodes"
    "https://github.com/Fannovel16/comfyui_controlnet_aux"
    "https://github.com/ShmuelRonen/ComfyUI-VideoUpscale_WithModel"
    "https://github.com/cubiq/ComfyUI_IPAdapter_plus"
    "https://github.com/justUmen/Bjornulf_custom_nodes"
    "https://github.com/numz/ComfyUI-SeedVR2_VideoUpscaler"
    "https://github.com/pythongosssss/ComfyUI-Custom-Scripts"
    "https://github.com/ssitu/ComfyUI_UltimateSDUpscale"
    "https://github.com/yolain/ComfyUI-Easy-Use-Frontend"
    "https://github.com/cubiq/ComfyUI_essentials"
    "https://github.com/yolain/ComfyUI-Easy-Use"
    "https://github.com/Fannovel16/ComfyUI-Frame-Interpolation"
    "https://github.com/city96/ComfyUI-GGUF"
    "https://github.com/chrisgoringe/cg-image-filter"
    "https://github.com/kijai/ComfyUI-KJNodes"
    "https://github.com/chflame163/ComfyUI_LayerStyle"
    "https://github.com/aria1th/ComfyUI-LogicUtils"
    "https://github.com/Comfy-Org/ComfyUI-Manager"
    "https://github.com/stavsap/comfyui-ollama"
    "https://github.com/1038lab/ComfyUI-RMBG"
    "https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite"
    "https://github.com/kijai/ComfyUI-WanVideoWrapper"
    "https://github.com/ClownsharkBatwing/RES4LYF"
    "https://github.com/rgthree/rgthree-comfy"
    "https://github.com/ltdrdata/was-node-suite-comfyui"
)

WORKFLOWS=()
FACE_RESTORE_MODELS=(
    "https://github.com/TencentARC/GFPGAN/releases/download/v1.3.4/GFPGANv1.4.pth"
)
VAE_MODELS=(
    #"https://huggingface.co/QuantStack/Wan2.2-TI2V-5B-GGUF/resolve/main/VAE/Wan2.2_VAE.safetensors"
    "https://huggingface.co/QuantStack/Wan2.2-I2V-A14B-GGUF/resolve/main/VAE/Wan2.1_VAE.safetensors"
    #"https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors"
    #"https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan2.2_vae.safetensors"
)
CLIP_VISION_MODELS=(
    # add clip vision for wan2.2
    "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/clip_vision/clip_vision_h.safetensors"
)
CLIP_MODELS=(
    # "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors"
    # "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp16.safetensors"
)
TEXT_ENCODERS=(
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp16.safetensors"
)

UNET_MODELS=(
    #"https://huggingface.co/QuantStack/Wan2.2-TI2V-5B-GGUF/resolve/main/Wan2.2-TI2V-5B-Q8_0.gguf"
    #"https://huggingface.co/QuantStack/Wan2.2-I2V-A14B-GGUF/resolve/main/LowNoise/Wan2.2-I2V-A14B-LowNoise-Q3_K_S.gguf"
    #"https://huggingface.co/QuantStack/Wan2.2-I2V-A14B-GGUF/resolve/main/HighNoise/Wan2.2-I2V-A14B-HighNoise-Q3_K_S.gguf"
    #"https://huggingface.co/QuantStack/Wan2.2-I2V-A14B-GGUF/resolve/main/LowNoise/Wan2.2-I2V-A14B-LowNoise-Q8_0.gguf"
    #"https://huggingface.co/QuantStack/Wan2.2-I2V-A14B-GGUF/resolve/main/HighNoise/Wan2.2-I2V-A14B-HighNoise-Q8_0.gguf"
)

LORA_MODELS=(
    "https://huggingface.co/lightx2v/Wan2.2-Lightning/resolve/main/Wan2.2-I2V-A14B-4steps-lora-rank64-Seko-V1/low_noise_model.safetensors"
    "https://huggingface.co/lightx2v/Wan2.2-Lightning/resolve/main/Wan2.2-I2V-A14B-4steps-lora-rank64-Seko-V1/high_noise_model.safetensors"
)
CIVIT_MODELS=(
    #"https://civitai.com/api/download/models/2057106?type=Archive&format=Other"
    2103699
    2103700
    2073605
    2083303
    2098405
    2098396
    2116027
    2116008
    2134314
    2127912
    2127901
    2087124
    2087173
    2124073
    2122049
    2145156
    2145089
    2122806
    2122834
    2152516
    2152583
    2149614
    2149593
    1652726
    1606639
    2156392
    2156435
    1752839
    2077123
    2077119
    1860691
    1606639
    1947888
    1585322
    1600755
    2099692
    1549343
    1590885
    1590885
    2121297
    1538301
    1545040
    1587648
)
DIFFUSION_MODELS=(
    #"https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/diffusion_models/wan2.1_t2v_1.3B_fp16.safetensors"
    #"https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_ti2v_5B_fp16.safetensors"
    #"https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_i2v_low_noise_14B_fp8_scaled.safetensors"
    #"https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_i2v_high_noise_14B_fp8_scaled.safetensors"
    #"https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_ti2v_5B_fp16.safetensors"
    #"https://huggingface.co/QuantStack/Wan2.2-TI2V-5B-GGUF/resolve/main/Wan2.2-TI2V-5B-Q8_0.gguf"
    #kijai
    # "https://huggingface.co/Kijai/WanVideo_comfy_fp8_scaled/resolve/main/I2V/Wan2_2-I2V-A14B-LOW_fp8_e4m3fn_scaled_KJ.safetensors"
    # "https://huggingface.co/Kijai/WanVideo_comfy_fp8_scaled/resolve/main/I2V/Wan2_2-I2V-A14B-HIGH_fp8_e4m3fn_scaled_KJ.safetensors"
)

function provisioning_start() {
    provisioning_print_header
    provisioning_get_apt_packages
    provisioning_get_nodes
    provisioning_get_pip_packages

    workflows_dir="${COMFYUI_DIR}/user/default/workflows"
    mkdir -p "${workflows_dir}"
    provisioning_get_files "${workflows_dir}" "${WORKFLOWS[@]}"
    provisioning_get_files "${COMFYUI_DIR}/models/unet" "${UNET_MODELS[@]}"
    provisioning_get_files "${COMFYUI_DIR}/models/vae" "${VAE_MODELS[@]}"
    provisioning_get_files "${COMFYUI_DIR}/models/text_encoders" "${TEXT_ENCODERS[@]}"
    provisioning_get_files "${COMFYUI_DIR}/models/loras" "${LORA_MODELS[@]}"
    provisioning_get_files "${COMFYUI_DIR}/models/clip" "${CLIP_MODELS[@]}"
    provisioning_get_files "${COMFYUI_DIR}/models/clip_vision" "${CLIP_VISION_MODELS[@]}"
    provisioning_get_files "${COMFYUI_DIR}/models/diffusion_models" "${DIFFUSION_MODELS[@]}"
    provisioning_get_files "${COMFYUI_DIR}/models/facerestore_models" "${FACE_RESTORE_MODELS[@]}"
    provisioning_civit_models_cli
    provisioning_print_end
}
function civit_depends() {
    if [[ -n $CIVIT_MODELS ]]; then
        for pkg in "${CIVIT_MODELS[@]}"; do
            civitai-models download "$pkg"
        done
    fi
}

function provisioning_gcloud() {
    echo "Installing gcloud SDK"
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    apt-get update && apt-get -y install google-cloud-cli
    gcloud --version
}

function provisioning_civit_models_cli() {
    cd $WORKSPACE
    git clone https://github.com/regiellis/civitai-models-cli.git
    cd civitai-models-cli
    pip install .
    #todo create .env file containing CIVITAI_TOKEN and MODELS_DIR
    mkdir -p $CIVIT_ENV_DIR
    cp sample.env $CIVIT_CLI_ENV
    set_env_details $CIVIT_CLI_ENV
    civit_depends
}
set_env_details() {
    local file="$1"
    if [ -f "$file" ] && [ -r "$file" ]; then
        # Update branch, hash, and version in the .env file
        sed -i "s/^CIVITAI_TOKEN=.*/CIVITAI_TOKEN=\"$CIVITAI_TOKEN\"/" "$file"
        sed -i "s|^MODELS_DIR=.*|MODELS_DIR=\"$MODELS_DIR\"|g" "$file"
        echo "Updated .env file: $file"
    else
        echo "Error: File does not exist or is not readable: $file"
    fi
}

function provisioning_get_apt_packages() {
    if [[ -n $APT_PACKAGES ]]; then
        $APT_INSTALL ${APT_PACKAGES[@]}
    fi
}

function provisioning_get_pip_packages() {
    if [[ -n $PIP_PACKAGES ]]; then
        pip install --no-cache-dir ${PIP_PACKAGES[@]}
    fi
}

function provisioning_get_nodes() {
    for repo in "${NODES[@]}"; do
        dir="${repo##*/}"
        path="${COMFYUI_DIR}/custom_nodes/${dir}"
        requirements="${path}/requirements.txt"
        if [[ -d $path ]]; then
            if [[ ${AUTO_UPDATE,,} != "false" ]]; then
                echo "Updating node: ${repo}"
                ( cd "$path" && git pull )
                [[ -e $requirements ]] && pip install --no-cache-dir -r "$requirements"
            fi
        else
            echo "Downloading node: ${repo}"
            git clone "${repo}" "${path}" --recursive
            [[ -e $requirements ]] && pip install --no-cache-dir -r "$requirements"
        fi
    done
}

function provisioning_get_files() {
    [[ -z $2 ]] && return 1
    dir="$1"
    mkdir -p "$dir"
    shift
    arr=("$@")
    echo "Downloading ${#arr[@]} file(s) to $dir..."
    for url in "${arr[@]}"; do
        echo "Downloading: $url"
        provisioning_download "$url" "$dir"
        echo
    done
}

function provisioning_print_header() {
    echo -e "\\n##############################################"
    echo -e "#          Provisioning container            #"
    echo -e "#         This will take some time           #"
    echo -e "# Your container will be ready on completion #"
    echo -e "##############################################\\n"
}

function provisioning_print_end() {
    echo -e "\\nProvisioning complete: Application will start now\\n"
}


function provisioning_has_valid_hf_token() {
    [[ -n "$HF_TOKEN" ]] || return 1
    url="https://huggingface.co/api/whoami-v2"

    response=$(curl -o /dev/null -s -w "%{http_code}" -X GET "$url" \
        -H "Authorization: Bearer $HF_TOKEN" \
        -H "Content-Type: application/json")

    # Check if the token is valid
    if [ "$response" -eq 200 ]; then
        return 0
    else
        return 1
    fi
}

function provisioning_has_valid_civitai_token() {
    [[ -n "$CIVITAI_TOKEN" ]] || return 1
    url="https://civitai.com/api/v1/models?hidden=1&limit=1"

    response=$(curl -o /dev/null -s -w "%{http_code}" -X GET "$url" \
        -H "Authorization: Bearer $CIVITAI_TOKEN" \
        -H "Content-Type: application/json")

    # Check if the token is valid
    if [ "$response" -eq 200 ]; then
        return 0
    else
        return 1
    fi
}

function provisioning_download() {
    if [[ -n $HF_TOKEN && $1 =~ ^https://([a-zA-Z0-9_-]+\.)?huggingface\.co(/|$|\?) ]]; then
        auth_token="$HF_TOKEN"
    elif 
        [[ -n $CIVITAI_TOKEN && $1 =~ ^https://([a-zA-Z0-9_-]+\.)?civitai\.com(/|$|\?) ]]; then
        auth_token="$CIVITAI_TOKEN"
    fi
    if [[ -n $auth_token ]];then
        wget --header="Authorization: Bearer $auth_token" -qnc --content-disposition --show-progress -e dotbytes="${3:-4M}" -P "$2" "$1"
    else
        wget -qnc --content-disposition --show-progress -e dotbytes="${3:-4M}" -P "$2" "$1"
    fi
}

if [[ ! -f /.noprovisioning ]]; then
    provisioning_start
fi
