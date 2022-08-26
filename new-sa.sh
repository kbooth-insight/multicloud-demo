
# export PROJECT_ID="anthos-exploration-356913"

# issuer=https://kubernetes.default.svc.cluster.local
WORKLOAD_IDENTITY_POOL="anthos-exploration-356913.svc.id.goog"
export KSA_NAME="mastery2022-on-prem-sa"
export NAMESPACE="demo"
export PROJECT_ID="anthos-exploration-356913"
export GCP_SA="${KSA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com"
export GCP_ROLE="roles/compute.storageAdmin"

echo "setting up: ${GCP_SA}"
# fleet_project=anthos-exploration-356913

# gcloud container fleet memberships describe k3s-nsitlabs --project ${PROJECT_ID}

# export provider="https://gkehub.googleapis.com/projects/anthos-exploration-356913/locations/global/memberships/k3s-nsitlabs"


# gcloud iam service-accounts create mastery2022-on-prem --project=${PROJECT_ID} 



kubectl create ns $NAMESPACE || true

# create service accounts in  both that do nothing for now
kubectl create sa $KSA_NAME --namespace $NAMESPACE
gcloud iam service-accounts create $KSA_NAME --project=$PROJECT_ID

# give the new gcp sa some permissions to do stuff
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member "serviceAccount:${GCP_SA}" \
    --role "roles/storage.objectAdmin"

export TEST_BINDING="serviceAccount:${WORKLOAD_IDENTITY_POOL}[$NAMESPACE/${KSA_NAME}]"
gcloud iam service-accounts add-iam-policy-binding \
  $GCP_SA \
  --role=roles/iam.workloadIdentityUser \
  --member="$TEST_BINDING"