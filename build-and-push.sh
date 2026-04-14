#!/bin/bash

# Script para build y push de imagen Docker
# Uso: ./build-and-push.sh [registry] [tag]

set -e

REGISTRY=${1:-ghcr.io}
IMAGE_NAME=${REGISTRY}/$(git config --get remote.origin.url | xargs basename -s .git)
TAG=${2:-latest}
FULL_IMAGE_NAME=${IMAGE_NAME}:${TAG}

echo "🔨 Construyendo imagen Docker..."
echo "📦 Imagen: $FULL_IMAGE_NAME"

# Verificar que Docker está corriendo
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker no está corriendo"
    exit 1
fi

# Build
docker build -t ${FULL_IMAGE_NAME} .

if [ $? -ne 0 ]; then
    echo "❌ Error en la construcción de la imagen"
    exit 1
fi

echo "✅ Imagen construida exitosamente"

# Tag como latest si no es latest
if [ "$TAG" != "latest" ]; then
    docker tag ${FULL_IMAGE_NAME} ${IMAGE_NAME}:latest
fi

# Push (solo si se proporciona registry diferente de local)
if [ "$REGISTRY" != "localhost" ]; then
    echo "📤 Empujando imagen a $REGISTRY..."
    docker push ${FULL_IMAGE_NAME}

    if [ "$TAG" != "latest" ]; then
        docker push ${IMAGE_NAME}:latest
    fi

    echo "✅ Imagen subida exitosamente"
else
    echo "ℹ️  Imagen local lista (no se hizo push)"
fi

# Mostrar resumen
echo ""
echo "📊 Resumen:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
docker images ${IMAGE_NAME}

