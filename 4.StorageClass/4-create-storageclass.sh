#!/bin/bash

MON1=95.217.166.88
MON2=95.216.214.79
MON3=95.217.166.221

cat <<EOF >./storage-class.yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: ceph-rbd
provisioner: ceph.com/rbd
parameters:
  monitors: $MON1:6789, $MON2:6789, $MON3:6789
  pool: kube
  adminId: admin
  adminSecretNamespace: ceph-system
  adminSecretName: ceph-admin-secret
  userId: kube
  userSecretNamespace: ceph-system
  userSecretName: ceph-secret
  imageFormat: "2"
  imageFeatures: layering
EOF

kubectl apply -f storage-class.yaml
