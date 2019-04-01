#!/usr/bin/env bash

#
# Fetch token (which will expire in 12 hours)
#

TOKEN=`aws ecr get-authorization-token --output text --query authorizationData[].authorizationToken | base64 -D | cut -d: -f2`

#
# Create or repleace registry secret
#
SECRET_NAME=ecr-secret
kubectl delete secret --ignore-not-found $SECRET_NAME
kubectl create secret docker-registry $SECRET_NAME \
 --docker-server=https://417025923863.dkr.ecr.ap-northeast-1.amazonaws.com \
 --docker-username=AWS \
 --docker-password="${TOKEN}" \
 --docker-email=""
