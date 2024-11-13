# 1. Build the guestbook app

# change to v1/guestbook

cd v1/guestbook

# complete dockerfile

# export namespace

export MY_NAMESPACE=sn-labs-$USERNAME

# build guestbook app

docker build . -t us.icr.io/$MY_NAMESPACE/guestbook:v1

# push the image

docker push us.icr.io/$MY_NAMESPACE/guestbook:v1

# verfiy image was pushed successfully

ibmcloud cr images

# apply deployment

kubectl apply -f deployment.yml

# open new terminal
# view app via

kubectl port-forward deployment.apps/guestbook 3000:3000

# 2. Autoscale the Guestbook application using Horizontal Pod Autoscaler

kubectl autoscale deployment guestbook --cpu-percent=5 --min=1 --max=10

# check current status

kubectl get hpa guestbook

# generate load with correct url

kubectl run -i --tty load-generator --rm --image=busybox:1.36.0 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- https://cjuergens-3000.theiaopenshiftnext-1-labs-prod-theiaopenshift-4-tor01.proxy.cognitiveclass.ai/; done"

# observe replicas increase

kubectl get hpa guestbook --watch

# observe details of hpa

kubectl get hpa guestbook

# 3. Perform Rolling Updates and Rollbacks on the Guestbook application

# update index.html

# build and push your updated app image

docker build . -t us.icr.io/$MY_NAMESPACE/guestbook:v1 && docker push us.icr.io/$MY_NAMESPACE/guestbook:v1

# update values in deployment.yml

# apply changes

kubectl apply -f deployment.yml

# in new terminal, run port-forward 

kubectl port-forward deployment.apps/guestbook 3000:3000

# in old terminal, see history of deployments

kubectl rollout history deployment/guestbook

# details of revision of the deployment

kubectl rollout history deployments guestbook --revision=2

# get replica sets and observe deployment

kubectl get rs

# undo deployment

kubectl rollout undo deployment/guestbook --to-revision=1

# get replica sets and observe 

kubectl get rs

