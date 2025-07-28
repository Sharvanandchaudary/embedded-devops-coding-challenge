#!/bin/bash

# Replace the following placeholders with your GitHub Enterprise information
GITHUB_API_URL="https://github.cadence.com/api/v3"
GITHUB_URL="https://github.cadence.com/"
#REPO_OWNER="IT"
#REPO_NAME="terraform-cloud30v2-aws"
GITHUB_PAT="$GITHUB_TOKEN"
RUNNER_WORKDIR="_work"
random_number=$((RANDOM % 100 + 1))
hname="github-docker-runner-"
RUNNER_NAME="$HOSTNAME"
RUNNER_LABLR="_work"
export  HOME=/ghrunner
#GITHUB_PAT="$GITHUB_TOKEN"
#ln -s /usr/bin/nodejs /usr/local/bin/node
RUNNER_LABLE="k8-blr-eks-cluster"
# Fetch the token from the repository
TOKEN=$(curl -s -XPOST \
        -H "Authorization: Bearer $GITHUB_TOKEN" \
        -H "Accept: application/vnd.github.v3+json" \
        "https://github.cadence.com/api/v3/repos/$REPO_OWNER/$REPO_NAME/actions/runners/registration-token" \
        | jq -r '.token')

echo $TOKEN

# Configure the runner with the fetched token


#./config.sh --url "https://github.cadence.com/$REPO_OWNER/$REPO_NAME" --token "$TOKEN" --name "${RUNNER_NAME}" --work "${RUNNER_WORKDIR}" --labels "${RUNNER_NAME}" --unattended --replace
#./config.sh --url "https://github.cadence.com/IT/OnCloud_IaC_Test" --token "$TOKEN" --name "${RUNNER_NAME}" --work "${RUNNER_WORKDIR}" --labels "k8-cluster" --unattended --replace

./config.sh --url "https://github.cadence.com/$REPO_OWNER/$REPO_NAME" --token "$TOKEN" --name "${RUNNER_NAME}" --work "${RUNNER_WORKDIR}" --labels "cloud30-docker-mvp" --unattended --replace


# Start the runner
./run.sh
