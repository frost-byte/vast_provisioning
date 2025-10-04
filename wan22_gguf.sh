#!/bin/bash

#sudo apt update; sudo apt install python3.10-venv
#python3 -m venv comfyui-env
#comfy install
#sudo ufw enable
#sudo ufw allow 22
#sudo ufw allow 8188
#source /home/user/comfyui-env/bin/activate
source /opt/venv/bin/activate

WORKSPACE=/workspace
SECRETS=$WORKSPACE/secrets
COMFYUI_DIR=${WORKSPACE}/ComfyUI
OUTPUT_DIR=${COMFYUI_DIR}/output
INPUT_DIR=${COMFYUI_DIR}/input
WORKFLOWS_DIR=${COMFYUI_DIR}/user/default/workflows
CIVIT_CLI_DIR=${WORKSPACE}/civitai-models-cli
MODELS_DIR=${COMFYUI_DIR}/models/
LORAS_DIR=${MODELS_DIR}loras
VAE_DIR=${MODELS_DIR}vae
UNETS_DIR=${MODELS_DIR}unet
NODES_DIR=${COMFYUI_DIR}/custom_nodes
CIVIT_ENV_DIR=~/.civitai-model-manager
CIVIT_CLI_ENV=${CIVIT_ENV_DIR}/.env
APT_PACKAGES=(
    "nano"
    "Python3.12-dev"
    "build-essential"
    "coreutils"
    "zip"
    "apt-transport-https"
    "ca-certificates"
    "gnupg"
    "curl"
    "cmake"
    "libgl1"
    "libglib2.0-0"
)
PIP_PACKAGES=(
    #"comfy-cli"
    #"sageattention"
    "pip"
    "setuptools"
    "wheel"
    "cmake"
    "onnxruntime-gpu"
    "onnxruntime"
    "insightface==0.7.3"
    "ultralytics"
#    "soxr==0.3.7"
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
    "https://github.com/StableLlama/ComfyUI-basic_data_handling"
    "https://github.com/justUmen/Bjornulf_custom_nodes"
    "https://github.com/Fannovel16/comfyui_controlnet_aux"
    "https://github.com/Acly/comfyui-inpaint-nodes"
    "https://github.com/crystian/ComfyUI-Crystools"
    "https://github.com/pythongosssss/ComfyUI-Custom-Scripts"
    "https://github.com/yolain/ComfyUI-Easy-Use"
    "https://github.com/yolain/ComfyUI-Easy-Use-Frontend"
    "https://github.com/cubiq/ComfyUI_essentials"
    "https://github.com/FizzleDorf/ComfyUI_FizzNodes"
    "https://github.com/Fannovel16/ComfyUI-Frame-Interpolation"
    "https://github.com/calcuis/gguf"
    "https://github.com/city96/ComfyUI-GGUF"
    "https://github.com/chrisgoringe/cg-image-filter"
    "https://github.com/cubiq/ComfyUI_IPAdapter_plus"
    "https://github.com/Amorano/Jovimetrix"
    "https://github.com/kijai/ComfyUI-KJNodes"
    "https://github.com/chflame163/ComfyUI_LayerStyle"
    "https://github.com/theUpsider/ComfyUI-Logic"
    "https://github.com/aria1th/ComfyUI-LogicUtils"
    "https://github.com/Comfy-Org/ComfyUI-Manager"
    "https://github.com/stavsap/comfyui-ollama"
    "https://github.com/Gourieff/ComfyUI-ReActor"
    "https://github.com/ClownsharkBatwing/RES4LYF"
    "https://github.com/rgthree/rgthree-comfy"
    "https://github.com/1038lab/ComfyUI-RMBG"
    "https://github.com/r-vage/ComfyUI-RvTools_v2"
    "https://github.com/numz/ComfyUI-SeedVR2_VideoUpscaler"
    "https://github.com/ssitu/ComfyUI_UltimateSDUpscale"
    "https://github.com/chrisgoringe/cg-use-everywhere"
    "https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite"
    "https://github.com/ShmuelRonen/ComfyUI-VideoUpscale_WithModel"
    "https://github.com/kijai/ComfyUI-WanVideoWrapper"
    "https://github.com/ltdrdata/was-node-suite-comfyui"
)

WORKFLOWS=()
FACE_RESTORE_MODELS=(
    "https://github.com/TencentARC/GFPGAN/releases/download/v1.3.4/GFPGANv1.4.pth"
)
UPSCALE_MODELS=(
    "https://huggingface.co/Kim2091/UltraSharp/resolve/main/4x-UltraSharp.pth"
)
VAE_MODELS=(
    #"https://huggingface.co/QuantStack/Wan2.2-TI2V-5B-GGUF/resolve/main/VAE/Wan2.2_VAE.safetensors"
    "https://huggingface.co/QuantStack/Wan2.2-I2V-A14B-GGUF/resolve/main/VAE/Wan2.1_VAE.safetensors"
    "https://huggingface.co/black-forest-labs/FLUX.1-schnell/resolve/main/ae.safetensors"
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
    #"https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors"
    #"https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors"
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp16.safetensors"
)

UNET_MODELS=(
    #"https://huggingface.co/QuantStack/Wan2.2-TI2V-5B-GGUF/resolve/main/Wan2.2-TI2V-5B-Q8_0.gguf"
    #"https://huggingface.co/QuantStack/Wan2.2-I2V-A14B-GGUF/resolve/main/LowNoise/Wan2.2-I2V-A14B-LowNoise-Q5_1.gguf"
    #"https://huggingface.co/QuantStack/Wan2.2-I2V-A14B-GGUF/resolve/main/HighNoise/Wan2.2-I2V-A14B-HighNoise-Q5_1.gguf"
    #"https://huggingface.co/QuantStack/Wan2.2-I2V-A14B-GGUF/resolve/main/LowNoise/Wan2.2-I2V-A14B-LowNoise-Q8_0.gguf"
    #"https://huggingface.co/QuantStack/Wan2.2-I2V-A14B-GGUF/resolve/main/HighNoise/Wan2.2-I2V-A14B-HighNoise-Q8_0.gguf"
    #"https://huggingface.co/wsbagnsv1/SkyReels-V2-DF-14B-720P-GGUF/resolve/main/Skywork-SkyReels-V2-DF-14B-720P-Q8_0.gguf"
)

LORA_MODELS=(
    "https://huggingface.co/lightx2v/Wan2.2-Lightning/resolve/main/Wan2.2-I2V-A14B-4steps-lora-rank64-Seko-V1/low_noise_model.safetensors"
    "https://huggingface.co/lightx2v/Wan2.2-Lightning/resolve/main/Wan2.2-I2V-A14B-4steps-lora-rank64-Seko-V1/high_noise_model.safetensors"
    "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan22-Lightning/Wan2.2-Lightning_I2V-A14B-4steps-lora_HIGH_fp16.safetensors"
    "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan22-Lightning/Wan2.2-Lightning_I2V-A14B-4steps-lora_LOW_fp16.safetensors"
)
CIVIT_MODELS=(
    #"https://civitai.com/api/download/models/2057106"
    #https://civitai.com/api/download/models/1934867
    #https://civarchive.com/models/1684874?modelVersionId=1934867
    #https://civarchive.com/models/1814871?modelVersionId=2161335
    #https://civarchive.com/models/1814871?modelVersionId=2161329
    2124073
    2122049
    2178869
    2176450
    2161335
    2161329
    1934867
    1571626
    1620834
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
    2145156
    2145089
    2122806
    2122834
    2152516
    2152583
    2149614
    2149593
    1652726
    2156392
    2156435
    1752839
    2077123
    2077119
    1860691
    1947888
    1585322
    1516873
    1600755
    1975021
    2099692
    1549343
    1590885
    1590885
    2121297
    1538301
    1545040
    1587648
    2028794 # wan2.1 "r3turnth15rsacp"
    2088443
    2088264
    1358184
    1534254
    1768094
    2095954
    2095952
    2185444
    2185457
    2055564
    2177091
    1996461
    2202387
    2202386
    2176200
    2176194
    1475095
    1816434
    1855263
    2221413
    2221311
    2183383
    2183388
    2215517
    2215698
    2235299
    2235288
    1652726
    2149614
    2176194
    1960177
    1606639
    1666048
    1599906
    2243201
    2243217
    2248727
    2249697
    2249683
    2183383
    2183388
    2221413
    2221311
    2215731
    2085376
    2197409
    2085369
    1682350
    2204122
    2248681
    2250571
    2250590
    2183000
    2182983
)
DIFFUSION_MODELS=(
     "https://huggingface.co/black-forest-labs/FLUX.1-Fill-dev/resolve/main/flux1-fill-dev.safetensors"
    #"https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_ti2v_5B_fp16.safetensors"
    #"https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_i2v_low_noise_14B_fp8_scaled.safetensors"
    #"https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_i2v_high_noise_14B_fp8_scaled.safetensors"
    #"https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_ti2v_5B_fp16.safetensors"
    #kijai
    # "https://huggingface.co/Kijai/WanVideo_comfy_fp8_scaled/resolve/main/I2V/Wan2_2-I2V-A14B-LOW_fp8_e4m3fn_scaled_KJ.safetensors"
    # "https://huggingface.co/Kijai/WanVideo_comfy_fp8_scaled/resolve/main/I2V/Wan2_2-I2V-A14B-HIGH_fp8_e4m3fn_scaled_KJ.safetensors"
)

function provisioning_start() {
    provisioning_print_header
    provisioning_get_apt_packages
    provisioning_get_nodes
    provisioning_get_pip_packages
    provisioning_gcloud
    #sage_attention # may not be necessary, just use the right quantized model in the sage attention options, (triton jit)
    gcloud_storage_get
    #gcloud_storage_put
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
    provisioning_get_files "${COMFYUI_DIR}/models/upscale_models" "${UPSCALE_MODELS[@]}"
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

function sage_attention() {
    wget https://developer.download.nvidia.com/compute/cuda/12.8.0/local_installers/cuda-repo-ubuntu2404-12-8-local_12.8.0-570.86.10-1_amd64.deb
    dpkg -i cuda-repo-ubuntu2404-12-8-local_12.8.0-570.86.10-1_amd64.deb
    cp /var/cuda-repo-ubuntu2404-12-8-local/cuda-*-keyring.gpg /usr/share/keyrings/
    apt-get update
    apt-get -y install cuda-toolkit-12-8
    echo 'export PATH=/usr/local/cuda-12.8/bin:$PATH' | tee /etc/profile.d/cuda.sh
    echo 'export LD_LIBRARY_PATH=/usr/local/cuda-12.8/lib64:${LD_LIBRARY_PATH}' | tee -a /etc/profile.d/cuda.sh
    source /etc/profile.d/cuda.sh
    which nvcc && nvcc --version
    cd $WORKSPACE
    # install deps, then build SageAttention from source
    git clone https://github.com/thu-ml/SageAttention
    cd SageAttention
    python setup.py install
}

# Requires GCP_SA_KEY_B64 env variable to be set (base64 encoded service account key
# Also include project id as and env variable GCP_PROJECT_ID,GCP_PROJECT, and include GCP_SERVICE_ACCT
function provisioning_gcloud() {
    if [[ -n "${GCP_SA_KEY_B64:-}" ]]; then
        mkdir -p $SECRETS && chmod 700 $SECRETS
        echo "$GCP_SA_KEY_B64" | base64 -d > $SECRETS/gcp-sa.json
        chmod 600 $SECRETS/gcp-sa.json
        export GOOGLE_APPLICATION_CREDENTIALS=$SECRETS/gcp-sa.json
        echo "Installing gcloud SDK"
        curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
        echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
        apt-get update && apt-get -y install google-cloud-cli
        gcloud --version
        # CLOUDSDK_CORE_PROJECT
        gcloud config set project "$GCP_PROJECT_ID"
        gcloud auth activate-service-account "$GCP_SERVICE_ACCT" --key-file="$SECRETS/gcp-sa.json" || true
    fi
}

function gcloud_storage_get() {
    if [[ -n "${GCP_PROJECT_ID:-}" ]]; then
        #gcloud storage rsync "gs://${GCP_BUCKET}${MODELS_DIR}" "$MODELS_DIR"
        gcloud storage rsync "gs://${GCP_BUCKET}${LORAS_DIR}" "$LORAS_DIR"
        #gcloud storage rsync "gs://${GCP_BUCKET}${WORKFLOWS_DIR}" "$WORKFLOWS_DIR"
        #gcloud storage rsync "gs://${GCP_BUCKET}${WORKFLOWS_DIR}" "$WORKFLOWS_DIR"
        gcloud storage rsync "gs://${GCP_BUCKET}${NODES_DIR}" "$NODES_DIR"
    fi
}
#        gcloud storage cp "/workspace/wan22_gguf.sh" "gs://${GCP_BUCKET}/workspace/wan22_gguf.sh"
#        gcloud storage cp "/workspace/sanity_sage.py" "gs://${GCP_BUCKET}/workspace/sanity_sage.py"
function gcloud_storage_put() {
    if [[ -n "${GCP_PROJECT_ID:-}" ]]; then
        #gcloud storage rsync "$MODELS_DIR" "gs://${GCP_BUCKET}${MODELS_DIR}"
        gcloud storage cp "$WORKSPACE/wan22_gguf.sh" "gs://${GCP_BUCKET}${WORKSPACE}/wan22_gguf.sh"
 #       gcloud storage rsync "$LORAS_DIR" "gs://${GCP_BUCKET}${LORAS_DIR}"
        gcloud storage rsync "$WORKFLOWS_DIR" "gs://${GCP_BUCKET}${WORKFLOWS_DIR}"
        zip -r "$OUTPUT_DIR/output.zip" $OUTPUT_DIR -x "$OUTPUT_DIR/output.zip"
        gcloud storage cp "$OUTPUT_DIR/output.zip" "gs://${GCP_BUCKET}/output.zip"
        zip "$INPUT_DIR/input.zip" $INPUT_DIR -x "$INPUT_DIR/input.zip"
        gcloud storage cp "$INPUT_DIR/input.zip" "gs://${GCP_BUCKET}/input.zip"
        #gcloud storage rsync "$OUTPUT_DIR" "gs://${GCP_BUCKET}${OUTPUT__DIR}"
#        gcloud storage rsync "$NODES_DIR" "gs://${GCP_BUCKET}${NODES_DIR}"
    fi
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
        apt-get update
        $APT_INSTALL ${APT_PACKAGES[@]}
    fi
}

function provisioning_get_pip_packages() {
    if [[ -n $PIP_PACKAGES ]]; then
        pip install --no-cache-dir ${PIP_PACKAGES[@]}
        pip uninstall -y soxr
        pip install soxr # specify a different version (not 1.0, perhaps 0.3.7?) also it's a sound library, so not really needed
        # but it is a requirement of some custom nodes that provide audio alertsw
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
    #gcloud_storage_put
    gcloud_storage_get
fi
