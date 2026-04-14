#!/bin/bash

# Script de despliegue en Kubernetes
# Uso: ./deploy.sh [dev|prod]

set -e

ENVIRONMENT=${1:-dev}
NAMESPACE=${NAMESPACE:-default}
IMAGE_REGISTRY=ghcr.io
IMAGE_NAME=ncruz-user
IMAGE_TAG=${IMAGE_TAG:-latest}

echo "🚀 Desplegando $IMAGE_NAME en $ENVIRONMENT..."

# Validar entorno
if [ "$ENVIRONMENT" != "dev" ] && [ "$ENVIRONMENT" != "prod" ]; then
    echo "❌ Entorno inválido. Use 'dev' o 'prod'"
    exit 1
fi

# Crear namespace si no existe
kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

# Crear secretos si no existen
kubectl create secret generic ncruz-user-secrets \
    --from-literal=db.username=sa \
    --from-literal=db.password="" \
    -n $NAMESPACE \
    --dry-run=client -o yaml | kubectl apply -f -

# Aplicar manifiestos
echo "📦 Aplicando Deployment..."
kubectl apply -f k8s/deployment.yaml -n $NAMESPACE

echo "🌐 Aplicando Ingress..."
kubectl apply -f k8s/ingress.yaml -n $NAMESPACE

# Esperar a que esté listo
echo "⏳ Esperando a que el deployment esté listo..."
kubectl rollout status deployment/ncruz-user -n $NAMESPACE --timeout=5m

# Mostrar información
echo "✅ Despliegue completado!"
echo ""
echo "📊 Estado del Deployment:"
kubectl get deployment ncruz-user -n $NAMESPACE
echo ""
echo "🔗 Servicio:"
kubectl get svc ncruz-user -n $NAMESPACE
echo ""
echo "📝 Logs:"
kubectl logs -f deployment/ncruz-user -n $NAMESPACE --tail=50

